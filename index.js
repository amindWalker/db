// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 }));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 
app.get("/api/hello", function (req, res) {
  res.json({ greeting: 'hello API' });
});

app
  .route("/api/:date?")
  .get(function (req, res) {
    const inputDate = req.params.date;
    if (inputDate === undefined) {
      const currentTime = new Date();
      res.json({ unix: currentTime.getTime(), utc: currentTime.toUTCString() });
      return;
    }

    let parsedDate = new Date(inputDate);
    let unixTime = parsedDate.getTime();
    // ^\d+$ match all characters that are valid digits
    if (/^\d+$/.test(inputDate)) { // all characters are numbers, possibly Unix Time in miliseconds
      unixTime = Number.parseInt(inputDate);
      parsedDate = new Date(unixTime);
      res.json({ unix: unixTime, utc: parsedDate.toUTCString() });
      return;
    }
    if (parsedDate == "Invalid Date") {
      res.json({ error: "Invalid Date" });
      return;
    };

    res.json({ unix: parsedDate.getTime(), utc: parsedDate.toUTCString() });
  });


// listen for requests :)
var listener = app.listen(3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
