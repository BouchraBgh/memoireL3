const User = require('../models/user');
const jwt = require("jsonwebtoken");
const bcrypt = require('bcrypt');

const login=async (req,res) =>{
    try {
        const { SocialNumber, password } = req.body;
        if (!SocialNumber || !password) {
            throw new Error('Parameter are not correct');
        }
        const user = await User.findOne({ SocialNumber });
        if (!user) {
           return res.status(401).json({ status: false,Message: "utilisateur non trouvé" });
        }
        // Check if password is correct
        const auth = await bcrypt.compare(password, user.password);
        if (!auth) {
            return res.status(401).json({ status: false,Message: "mot de passe incorrect" });
        }
        // Creating Token
        const tokenData= { _id: user._id };
        const userData={SocialNumber: user.SocialNumber,name:user.name,familyName:user.familyName}
        const token = jwt.sign(tokenData, "secret", { expiresIn: "1h" })
        res.status(200).json({ status: true, userData, token: token });
    } catch (error) {
        console.log(error, 'err---->');
    }
}
const getuserData = async (req, res) => {
    try {
      const { userId } = req.body;
      const user = await User.findById(userId);
      if (!user) {
        return res.status(401).json({ status: false, Message: "utilisateur non trouvé" });
      }
      const userData = { SocialNumber: user.SocialNumber, name: user.name, familyName: user.familyName };
      res.status(200).json({ status: true, userData: userData });
    } catch (error) {
      console.log(error, 'err---->');
    }
  };
const createUser = async (req, res) => {
  //crypet the password befor store it in db
  const salt = await bcrypt.genSalt();
  req.body.password= await bcrypt.hash(req.body.password, salt);
  const user = new User(req.body);
  console.log(req.body);
  user.save()
    .then(result => {
      res.status(200).json(result);
    })
    .catch(err => {
      console.log(err);
      res.status(401).json({ errors });
    });
}
  

module.exports = { login,getuserData,createUser};