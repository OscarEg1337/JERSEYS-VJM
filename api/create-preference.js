module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { items } = req.body;
  if (!items || items.length === 0) return res.status(400).json({ error: 'No items' });

  const preference = {
    items: items.map(function(item) {
      return {
        title: item.nombre,
        quantity: 1,
        unit_price: Number(item.precio),
        currency_id: 'MXN'
      };
    }),
    back_urls: {
      success: 'https://jerseys-vjm.vercel.app/?pago=exito',
      failure: 'https://jerseys-vjm.vercel.app/?pago=error',
      pending: 'https://jerseys-vjm.vercel.app/?pago=pendiente'
    },
    auto_return: 'approved'
  };

  try {
    const mpRes = await fetch('https://api.mercadopago.com/checkout/preferences', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + process.env.MP_ACCESS_TOKEN
      },
      body: JSON.stringify(preference)
    });

    const data = await mpRes.json();

    if (!mpRes.ok) return res.status(500).json({ error: data.message || 'MP error' });

    res.json({ init_point: data.init_point });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
