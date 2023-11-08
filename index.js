require('dotenv').config();
const bodyParser = require('body-parser');
const express = require('express');
const cors = require('cors');
const app = express();

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function (req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function (req, res) {
  res.json({ greeting: 'hello API' });
});

const shortUrlList = [];
let short_url = 0;
app
  .route("/api/shorturl")
  .post(function (req, res) {
    const original_url = req.body.url;
    console.log(shortUrlList);
    const isUrl = /^https?:\/\/.+/;
    if (!isUrl.test(original_url)) return res.json({ error: "invalid url" });

    shortUrlList.push({ original_url, short_url: ++short_url });
    res.json({ original_url, short_url });
  })
app
  .route("/api/shorturl/:short_url")
  .get(function (req, res) {
    const shortUrl = Number.parseInt(req.params.short_url);
    const hasEntry = shortUrlList.find((url) => url.short_url == shortUrl);
    if (!hasEntry) {
      return res.json({ error: 'short url not found' });
    }

    res.redirect(hasEntry.original_url);
  });

app.listen(port, function () {
  console.log(`Listening on port ${port}`);
});