const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const VaccinSchema = new Schema({
    user:{
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    name: {
        type: String,
        required:true
    },
    age: {
        type:Number,
        required:true 
    },
    date: {
        type:Date,
        required:true
    },
    isVaccined:{
        type:Boolean,
        default:false,
    },
    note: {
        type: String,
    }
});
  
const Vaccin = mongoose.model('Vaccin', VaccinSchema);

module.exports = Vaccin;