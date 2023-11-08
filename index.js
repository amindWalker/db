const express = require('express')
const app = express()
const cors = require('cors')
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
require('dotenv').config()

// Root Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors())
app.use(express.static('public'))

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

// MongoDB connection
mongoose.connect(process.env.MONGO_URI);

// Generic function to handle all dates to 'Week Month Day Year' format
function formatDate(date) {
  const options = { weekday: 'short', month: 'short', day: '2-digit', year: 'numeric' };
  return date.toLocaleDateString('en-US', options);
};

const userSchema = new mongoose.Schema({
  username: String,
  exercises: [{
    description: String,
    duration: Number,
    date: Date
  }]
});

const User = mongoose.model('User', userSchema);

app.post('/api/users', async (req, res) => {
  try {
    const { username } = req.body;
    const newUser = new User({ username });
    const savedUser = await newUser.save();
    res.json({ username: savedUser.username, _id: savedUser._id });
  } catch (error) {
    res.json({ error: 'Could not create a new user' });
  }
});

app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find({});
    res.json(users);
  } catch (error) {
    res.json({ error: 'Could not retrieve users' });
  }
});

app.post('/api/users/:_id/exercises', async (req, res) => {
  try {
    const { description, duration, date } = req.body;
    const { _id } = req.params;

    const user = await User.findById(_id);

    if (!user) {
      res.json({ error: 'Could not find the user' });
      return;
    }

    const dateObj = date ? new Date(date) : new Date();
    const formattedDate = dateObj.toDateString();

    const newExercise = { description, duration: parseInt(duration), date: formattedDate };
    user.exercises.push(newExercise);

    const responseExercise = {
      description: newExercise.description,
      duration: newExercise.duration,
      date: newExercise.date
    };

    await user.save();
    console.log({ username: user.username, _id: user._id, ...responseExercise });
    res.json({ username: user.username, _id: user._id, ...responseExercise });
  } catch (error) {
    res.json({ error: 'Could not add exercise' });
  }
});

app.get('/api/users/:_id/logs', async (req, res) => {
  try {
    const { _id } = req.params;
    const { from, to, limit } = req.query;

    const user = await User.findById(_id);

    if (!user) {
      res.json({ error: 'Could not find the user' });
      return;
    }

    let log = user.exercises;

    if (from && to) {
      log = log.filter(exercise => exercise.date >= new Date(from) && exercise.date <= new Date(to));
    }

    if (limit) {
      log = log.slice(0, limit);
    }

    const logFormatted = log.map(exercise => ({
      description: exercise.description,
      duration: exercise.duration,
      date: exercise.date.toDateString()
    }));

    res.json({
      _id: user._id,
      username: user.username,
      count: log.length,
      log: logFormatted
    });
  } catch (error) {
    res.json({ error: 'An error occurred while processing the request' });
  }
});

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})