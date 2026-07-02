module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).end();

  const { type, record, old_record } = req.body || {};

  if (type !== 'UPDATE') return res.status(200).end();
  if (!record || record.estado !== 'pagado') return res.status(200).end();
  if (old_record && old_record.estado === 'pagado') return res.status(200).end();

  const p = record;
  const tipoEnvio = p.tipo_envio === 'dhl' ? 'DHL Express ($250 MXN)' : 'Correos de México ($70 MXN)';

  /* ── Email para Oscar (admin) ── */
  const htmlAdmin = `
    <div style="font-family:sans-serif;max-width:540px;margin:auto;border:1px solid #e5e7eb;border-radius:8px;overflow:hidden">
      <div style="background:#111827;padding:20px 24px">
        <h2 style="color:#fff;margin:0">🛒 Nueva venta — VJM</h2>
      </div>
      <div style="padding:24px">
        <h3 style="margin-top:0;border-bottom:1px solid #e5e7eb;padding-bottom:8px">Datos del cliente</h3>
        <p style="margin:4px 0"><strong>Nombre:</strong> ${p.nombre_envio || '—'}</p>
        <p style="margin:4px 0"><strong>Teléfono:</strong> ${p.telefono_envio || '—'}</p>
        <p style="margin:4px 0"><strong>Email:</strong> ${p.email_envio || '—'}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Dirección de envío</h3>
        <p style="margin:4px 0">${p.direccion_envio || '—'}</p>
        <p style="margin:4px 0"><strong>Tipo de envío:</strong> ${tipoEnvio}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Productos</h3>
        <p style="margin:4px 0">${p.items_resumen || '—'}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Total</h3>
        <p style="font-size:1.4rem;font-weight:bold;color:#16a34a;margin:4px 0">$${p.total} MXN</p>
      </div>
      <div style="background:#f9fafb;padding:12px 24px;font-size:12px;color:#6b7280">
        Pedido #${p.id} · VJM Jerseys México
      </div>
    </div>
  `;

  /* ── Email para el comprador ── */
  const htmlComprador = `
    <div style="font-family:sans-serif;max-width:540px;margin:auto;border:1px solid #e5e7eb;border-radius:8px;overflow:hidden">
      <div style="background:#111827;padding:20px 24px">
        <h2 style="color:#fff;margin:0">✅ ¡Tu pedido está confirmado!</h2>
        <p style="color:#9ca3af;margin:6px 0 0">VJM Jerseys México</p>
      </div>
      <div style="padding:24px">
        <p style="margin-top:0">Hola <strong>${p.nombre_envio || 'cliente'}</strong>, gracias por tu compra. Aquí está el resumen de tu pedido:</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Productos</h3>
        <p style="margin:4px 0">${p.items_resumen || '—'}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Envío</h3>
        <p style="margin:4px 0"><strong>Tipo:</strong> ${tipoEnvio}</p>
        <p style="margin:4px 0"><strong>Dirección:</strong> ${p.direccion_envio || '—'}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Total pagado</h3>
        <p style="font-size:1.4rem;font-weight:bold;color:#16a34a;margin:4px 0">$${p.total} MXN</p>

        <div style="background:#f0fdf4;border:1px solid #bbf7d0;border-radius:6px;padding:12px 16px;margin-top:20px">
          <p style="margin:0;color:#15803d;font-size:14px">
            📦 Te avisaremos cuando tu pedido sea enviado. Si tienes dudas, contáctanos por WhatsApp al <strong>+52 81 1654 4571</strong>.
          </p>
        </div>
      </div>
      <div style="background:#f9fafb;padding:12px 24px;font-size:12px;color:#6b7280">
        Pedido #${p.id} · VJM Jerseys México
      </div>
    </div>
  `;

  const headers = {
    'Authorization': 'Bearer ' + process.env.RESEND_API_KEY,
    'Content-Type': 'application/json'
  };

  try {
    /* Enviar ambos emails en paralelo */
    await Promise.all([
      fetch('https://api.resend.com/emails', {
        method: 'POST', headers,
        body: JSON.stringify({
          from: 'VJM Tienda <onboarding@resend.dev>',
          to: ['oscareguia55@gmail.com'],
          subject: '🛒 Nueva venta VJM — ' + (p.nombre_envio || 'Cliente'),
          html: htmlAdmin
        })
      }),
      p.email_envio ? fetch('https://api.resend.com/emails', {
        method: 'POST', headers,
        body: JSON.stringify({
          from: 'VJM Jerseys <onboarding@resend.dev>',
          to: [p.email_envio],
          subject: '✅ Pedido confirmado — VJM Jerseys México',
          html: htmlComprador
        })
      }) : Promise.resolve()
    ]);
  } catch (e) {
    console.error('Email error:', e.message);
  }

  res.status(200).end();
};
