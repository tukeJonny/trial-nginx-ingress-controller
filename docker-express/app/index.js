const fs = require('fs');
const path = require('path');

const app = require("express")();

app.get('/home', async (req, res) => {
    res.json({
      page: 'home',
      app: 'express.js'
    });
});

const start = async () => {
  try {
    await app.listen(3000, '0.0.0.0');
    console.log("server listening on 3000");
  } catch (err) {
    console.error(err);
  }
};
start();