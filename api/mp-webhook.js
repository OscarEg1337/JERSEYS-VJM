var crypto = require('crypto');

var SB_URL = 'https://cxcyghxnwldqzdghizsd.supabase.co';

/* Valida que la notificacion venga realmente de Mercado Pago, usando la
   firma HMAC que manda en el header x-signature. Sin esto, cualquiera podria
   mandar POSTs falsos a este endpoint (aunque no logren aprobar pagos falsos,
   si permiten floodear el servidor y gastar cuota de llamadas a MP/Supabase).
   Formula segun la doc oficial de MP (Tus integraciones > Webhooks > Firma). */
function firmaValida(req) {
  var xSignature = req.headers['x-signature'];
  var xRequestId = req.headers['x-request-id'];
  if (!xSignature || !xRequestId || !process.env.MP_WEBHOOK_SECRET) return false;

  var ts, hash;
  xSignature.split(',').forEach(function(part) {
    var kv = part.split('=');
    if (kv[0].trim() === 'ts') ts = kv[1] && kv[1].trim();
    if (kv[0].trim() === 'v1') hash = kv[1] && kv[1].trim();
  });
  if (!ts || !hash) return false;

  var dataId = String((req.query && req.query['data.id']) || '').toLowerCase();
  var manifest = 'id:' + dataId + ';request-id:' + xRequestId + ';ts:' + ts + ';';
  var hmac = crypto.createHmac('sha256', process.env.MP_WEBHOOK_SECRET).update(manifest).digest('hex');

  var hashBuf = Buffer.from(hash, 'hex');
  var hmacBuf = Buffer.from(hmac, 'hex');
  if (hashBuf.length !== hmacBuf.length) return false;
  return crypto.timingSafeEqual(hashBuf, hmacBuf);
}

/* La tabla pedidos tiene RLS por user_id (auth.uid() = user_id) y no tiene
   politica de UPDATE, asi que la clave publica no sirve para que el webhook
   (que no corre como ningun usuario logueado) lea ni actualice pedidos.
   Se necesita la Service Role Key, que ignora RLS, solo para uso server-side. */
function sbHeaders() {
  return {
    'apikey': process.env.SUPABASE_SERVICE_ROLE_KEY,
    'Authorization': 'Bearer ' + process.env.SUPABASE_SERVICE_ROLE_KEY,
    'Content-Type': 'application/json'
  };
}

/* Busca el pago aprobado y su external_reference, sin importar si MP avisó
   por topic=payment (webhooks v2) o topic=merchant_order (IPN clasico, el
   que realmente manda la API de checkout/preferences que usamos). */
async function resolvePagoAprobado(type, id) {
  var mpHeaders = { 'Authorization': 'Bearer ' + process.env.MP_ACCESS_TOKEN };

  if (type && type.indexOf('merchant_order') !== -1) {
    var moRes = await fetch('https://api.mercadopago.com/merchant_orders/' + id, { headers: mpHeaders });
    var order = await moRes.json();
    if (!moRes.ok || !order.payments) return null;

    var aprobado = order.payments.filter(function(p) { return p.status === 'approved'; })[0];
    if (!aprobado) return null;

    return { external_reference: order.external_reference };
  }

  var payRes = await fetch('https://api.mercadopago.com/v1/payments/' + id, { headers: mpHeaders });
  var payment = await payRes.json();
  if (!payRes.ok || payment.status !== 'approved') return null;

  return { external_reference: payment.external_reference };
}

module.exports = async function handler(req, res) {
  /* Mercado Pago a veces hace un ping GET al configurar la notification_url */
  if (req.method === 'GET') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).end();
  if (!firmaValida(req)) return res.status(401).end();

  var body = req.body || {};
  var query = req.query || {};

  var type = body.type || body.action || query.type || query.topic;
  var notifId = (body.data && body.data.id) || query['data.id'] || query.id;

  if (!notifId || !type) return res.status(200).end();

  try {
    var pago = await resolvePagoAprobado(type, notifId);
    if (!pago) return res.status(200).end();

    var pedidoId = pago.external_reference;
    if (!pedidoId) return res.status(200).end();

    var pedidoRes = await fetch(SB_URL + '/rest/v1/pedidos?id=eq.' + pedidoId + '&select=*', {
      headers: sbHeaders()
    });
    var pedidos = await pedidoRes.json();
    var pedido = pedidos && pedidos[0];
    if (!pedido) return res.status(200).end();

    /* Idempotencia: MP reintenta webhooks, no repetir el descuento de stock */
    if (pedido.estado === 'pagado') return res.status(200).end();

    var items = pedido.items_json || [];
    for (var i = 0; i < items.length; i++) {
      var productoId = items[i].producto_id;
      var tabla = items[i].tipo === 'parche' ? 'parches' : 'jerseys';

      var stockRes = await fetch(SB_URL + '/rest/v1/' + tabla + '?id=eq.' + productoId + '&select=cantidad', {
        headers: sbHeaders()
      });
      var stockRows = await stockRes.json();
      var row = stockRows && stockRows[0];
      if (!row) continue;

      var nuevaCantidad = row.cantidad - 1;
      await fetch(SB_URL + '/rest/v1/' + tabla + '?id=eq.' + productoId, {
        method: 'PATCH',
        headers: sbHeaders(),
        body: JSON.stringify({ cantidad: nuevaCantidad, disponible: nuevaCantidad > 0 })
      });
    }

    await fetch(SB_URL + '/rest/v1/pedidos?id=eq.' + pedidoId, {
      method: 'PATCH',
      headers: sbHeaders(),
      body: JSON.stringify({ estado: 'pagado' })
    });

    try {
      var pedidoActualizado = Object.assign({}, pedido, { estado: 'pagado' });
      var origin = 'https://' + req.headers.host;
      await fetch(origin + '/api/notificar-venta', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-internal-secret': process.env.INTERNAL_API_SECRET
        },
        body: JSON.stringify({
          type: 'UPDATE',
          record: pedidoActualizado,
          old_record: { estado: 'pendiente' }
        })
      });
    } catch (notifErr) {
      console.error('Error al enviar notificaciones:', notifErr.message);
    }

    return res.status(200).end();
  } catch (err) {
    console.error('Error en mp-webhook:', err.message);
    return res.status(200).end();
  }
};
