var SB_URL = 'https://cxcyghxnwldqzdghizsd.supabase.co';
var SB_KEY = 'sb_publishable_JFGxr4fGDNNa8cAiLG0S0w_nPP0cH1X';
var ADMIN_EMAIL = 'oscareguia55@gmail.com';

module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'GET') return res.status(405).end();

  var auth = req.headers.authorization || '';
  var token = auth.replace(/^Bearer\s+/i, '');
  if (!token) return res.status(403).json({ error: 'No autorizado' });

  try {
    var userRes = await fetch(SB_URL + '/auth/v1/user', {
      headers: { 'Authorization': 'Bearer ' + token, 'apikey': SB_KEY }
    });
    var user = await userRes.json();

    if (!userRes.ok || !user.email || user.email !== ADMIN_EMAIL) {
      return res.status(403).json({ error: 'No autorizado' });
    }

    var pedidosRes = await fetch(SB_URL + '/rest/v1/pedidos?select=*&order=created_at.desc', {
      headers: {
        'apikey': process.env.SUPABASE_SERVICE_ROLE_KEY,
        'Authorization': 'Bearer ' + process.env.SUPABASE_SERVICE_ROLE_KEY
      }
    });
    var pedidos = await pedidosRes.json();

    if (!pedidosRes.ok) return res.status(500).json({ error: 'Error al leer pedidos' });

    res.json(pedidos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
