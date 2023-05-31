const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const ConsultationSchema = new Schema({
    user:{
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    mois: {
        type:Number,
        required:true 
    },
    poids: {
        type:Number,
        required:true 
    },
    taille: {
        type:Number,
        required:true 
    },
});
  
const Consultation = mongoose.model('Consultation', ConsultationSchema);

module.exports = Consultation;