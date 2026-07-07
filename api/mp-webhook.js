var SB_URL = 'https://cxcyghxnwldqzdghizsd.supabase.co';
var SB_KEY = 'sb_publishable_JFGxr4fGDNNa8cAiLG0S0w_nPP0cH1X';

function sbHeaders() {
  return {
    'apikey': SB_KEY,
    'Authorization': 'Bearer ' + SB_KEY,
    'Content-Type': 'application/json'
  };
}

module.exports = async function handler(req, res) {
  /* Mercado Pago a veces hace un ping GET al configurar la notification_url */
  if (req.method === 'GET') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).end();

  var body = req.body || {};
  var query = req.query || {};

  var type = body.type || body.action || query.type || query.topic;
  var paymentId = (body.data && body.data.id) || query['data.id'] || query.id;

  /* Solo nos interesan notificaciones de pago; ignorar merchant_order, etc. */
  if (!paymentId || (type && type !== 'payment' && type.indexOf('payment') === -1)) {
    return res.status(200).end();
  }

  try {
    var mpRes = await fetch('https://api.mercadopago.com/v1/payments/' + paymentId, {
      headers: { 'Authorization': 'Bearer ' + process.env.MP_ACCESS_TOKEN }
    });
    var payment = await mpRes.json();

    if (!mpRes.ok || payment.status !== 'approved') {
      return res.status(200).end();
    }

    var pedidoId = payment.external_reference;
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
      var jerseyRes = await fetch(SB_URL + '/rest/v1/jerseys?id=eq.' + productoId + '&select=cantidad', {
        headers: sbHeaders()
      });
      var jerseys = await jerseyRes.json();
      var jersey = jerseys && jerseys[0];
      if (!jersey) continue;

      var nuevaCantidad = jersey.cantidad - 1;
      await fetch(SB_URL + '/rest/v1/jerseys?id=eq.' + productoId, {
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
        headers: { 'Content-Type': 'application/json' },
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
