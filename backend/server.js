const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());

const DB_PATH = path.join(__dirname, 'db.json');

function loadDB() {
  try { return JSON.parse(fs.readFileSync(DB_PATH, 'utf8')); }
  catch { return { products: [], orders: [], devices: [], users: [] }; }
}

function saveDB(data) {
  fs.writeFileSync(DB_PATH, JSON.stringify(data, null, 2));
}

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', service: 'kibalu', version: '1.0.0' });
});

// Stats
app.get('/api/stats', (req, res) => {
  const db = loadDB();
  const totalRevenue = db.orders.reduce((sum, o) => sum + (o.total || 0), 0);
  res.json({
    products: db.products.length,
    orders: db.orders.length,
    devices: db.devices.length,
    revenue: totalRevenue
  });
});

// Products (Catalogue)
app.get('/api/products', (req, res) => {
  const db = loadDB();
  res.json(db.products);
});

app.get('/api/products/:id', (req, res) => {
  const db = loadDB();
  const product = db.products.find(p => p.id == req.params.id);
  if (!product) return res.status(404).json({ error: 'Produit non trouvé' });
  res.json(product);
});

// Create order
app.post('/api/orders', (req, res) => {
  const db = loadDB();
  const order = {
    id: Date.now(),
    customer: req.body.customer || {},
    items: req.body.items || [],
    total: req.body.total || 0,
    status: 'pending',
    created_at: new Date().toISOString()
  };
  db.orders.push(order);
  saveDB(db);
  res.json(order);
});

// Devices (Dashboard gestion)
app.get('/api/devices', (req, res) => {
  const db = loadDB();
  res.json(db.devices);
});

app.post('/api/devices/:id/alert', (req, res) => {
  const db = loadDB();
  const device = db.devices.find(d => d.id == req.params.id);
  if (!device) return res.status(404).json({ error: 'Dispositif non trouvé' });
  device.last_alert = {
    type: req.body.type || 'vibration',
    message: req.body.message || 'Alerte détectée',
    timestamp: new Date().toISOString()
  };
  device.alerts_count = (device.alerts_count || 0) + 1;
  saveDB(db);
  res.json(device);
});

// Update device status
app.put('/api/devices/:id', (req, res) => {
  const db = loadDB();
  const device = db.devices.find(d => d.id == req.params.id);
  if (!device) return res.status(404).json({ error: 'Dispositif non trouvé' });
  Object.assign(device, req.body);
  device.updated_at = new Date().toISOString();
  saveDB(db);
  res.json(device);
});

const PORT = process.env.PORT || 3012;
app.listen(PORT, () => {
  console.log(`╔═══════════════════════════════════════════════╗`);
  console.log(`║  🔒 KIBALU — Security Solutions             ║`);
  console.log(`║  Port: ${PORT}                                  ║`);
  console.log(`║  API: http://localhost:${PORT}/api            ║`);
  console.log(`╚═══════════════════════════════════════════════╝`);
});
