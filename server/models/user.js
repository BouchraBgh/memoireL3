const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const UserSchema = new Schema({
    name: {
      type: String,
      required: true
    },
    familyName: {
      type: String,
      required: true
    },
    birthDate: {
      type: Date,
      required: true
    },
    placeOfBirth: {
      type: String,
      required: true
    },
    hospital: {
      type: String,
      required: true
    },
    Rh: {
        type: String,
        enum: ['A+', 'A-','B+','B-','AB+','AB-','O+','O-'],
        required: true
    },
    gender: {
        type: String,
        enum: ['Male' ,'Female'],
        required: true
    },
    address: {
      type: String,
      required: true
    },
    mobilePhone: {
      type: Number,
      required: true
    },
    SocialNumber: {
        type: Number,
        required: true
    },
    password: {
      type: String,
      required: true,
    },
    
  });
  
  const User = mongoose.model('User', UserSchema);
  
  module.exports = User;