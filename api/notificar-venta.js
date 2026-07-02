module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).end();

  const { type, record, old_record } = req.body || {};

  // Solo enviar cuando el estado cambia a 'pagado'
  if (type !== 'UPDATE') return res.status(200).end();
  if (!record || record.estado !== 'pagado') return res.status(200).end();
  if (old_record && old_record.estado === 'pagado') return res.status(200).end();

  const p = record;
  const tipoEnvio = p.tipo_envio === 'dhl' ? 'DHL Express ($250 MXN)' : 'Correos de México ($70 MXN)';

  const html = `
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
        <p style="margin:4px 0">${p.items_resumen || 'Ver Supabase'}</p>

        <h3 style="border-bottom:1px solid #e5e7eb;padding-bottom:8px">Total</h3>
        <p style="font-size:1.4rem;font-weight:bold;color:#16a34a;margin:4px 0">$${p.total} MXN</p>
      </div>
      <div style="background:#f9fafb;padding:12px 24px;font-size:12px;color:#6b7280">
        Pedido #${p.id} · VJM Jerseys México
      </div>
    </div>
  `;

  try {
    const emailRes = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': 'Bearer ' + process.env.RESEND_API_KEY,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'VJM Tienda <onboarding@resend.dev>',
        to: ['oscareguia55@gmail.com'],
        subject: '🛒 Nueva venta VJM — ' + (p.nombre_envio || 'Cliente'),
        html: html
      })
    });

    if (!emailRes.ok) {
      const err = await emailRes.json();
      console.error('Resend error:', err);
    }
  } catch (e) {
    console.error('Email error:', e.message);
  }

  res.status(200).end();
};
