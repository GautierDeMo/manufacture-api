const express = require('express');
const { calculTTC } = require('./tva');

const app = express();

app.get('/health', (req, res) => res.json({ status: 'ok' }));

app.get('/ttc', (req, res) => {
  const ht = Number(req.query.ht);
  res.json({ ht, ttc: calculTTC(ht, 0.2) });
});

module.exports = app;
