const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const DeveloppementSchema = new Schema({
    user:{
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    mois: {
        type:Number,
        required:true 
    },
    type: {
        type: String,
        enum: ['moteur' ,'cognitif','motricité fine'],
        required: true
    },
    note: {
        type: String,
        required: true
    },
});
  
const Developpement = mongoose.model('Developpement', DeveloppementSchema);

module.exports = Developpement;