const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const AutresInfoSchema = new Schema({
    user:{
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    date: {
        type:Date,
        required:true 
    },
    note: {
        type: String,
        required: true
    },
});
  
const AutresInfo = mongoose.model('AutresInfo', AutresInfoSchema);

module.exports = AutresInfo;