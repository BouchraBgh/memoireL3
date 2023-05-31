const express= require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app =express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());
app.use(cors({
    origin: '*',
  })); 
const dbURI=`mongodb+srv://${process.env.mongo_user}:${process.env.mongo_password}@cluster0.keb5vid.mongodb.net/vaccin?retryWrites=true&w=majority`
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(result => {
        app.listen(3000, () => {
            console.log("Server is running on port 3000 http://localhost:3000/") 
          }) 
    })
    .catch(err => console.log(err));

//routes
app.use('/auth', require('./routes/authRouter'));
app.use('/api', require('./routes/apiRouter'));