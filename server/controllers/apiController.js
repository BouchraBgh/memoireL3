const Vaccin=require('../models/vaccin')
const Developpement=require('../models/développement')
const AutresInfo=require('../models/autresInfo')
const User=require('../models/user')
const Consultation=require('../models/consultations')


const getLasteSyring = async (req, res) => {
    try {
      const userId  = req.params.userId;
      const vaccin = await Vaccin.findOne({ user: userId }).sort({ date: -1 }).limit(1).select('-__v -_id -user');
      if (!vaccin) {
        return res.status(404).json({ status: false, message: "No Vaccin found for the user" });
      }
      res.status(200).json({ status: true, vaccin }); 
    } catch (error) {
      console.log(error, 'err---->');
      res.status(500).json({ status: false, message: "Internal server error" });
    }
  };
const userInfo = async (req, res) => {
  const userId  = req.params.userId;
  const user = await User.findById(userId).select('-password');
  if (!user) {
     return res.status(401).json({ status: false,Message: "utilisateur non trouvé" });
    }
  return res.status(200).json({ status: true,user }); 
  };
const vaccinations = async (req, res) => {
    try {
      const userId  = req.params.userId;
      const vaccin = await Vaccin.find({ user: userId }).sort({ date: 1 }).select('-__v -_id -user');
      if (!vaccin) {
        return res.status(404).json({ status: false, message: "No Vaccin found for the user" });
      }
      res.status(200).json({ status: true, vaccin }); 
    } catch (error) {
      console.log(error, 'err---->');
      res.status(500).json({ status: false, message: "Internal server error" });
    }
  };
const createSyring = async (req, res) => {
    const vaccin = new Vaccin(req.body);
    vaccin.save()
      .then(result => {
        res.status(200).json(result);
      })
      .catch(err => {
        console.log(err);
        res.status(401).json({ errors });
      });
}
const createDeveloppement = async (req, res) => {
    const vaccin = new Developpement(req.body);
    vaccin.save()
      .then(result => {
        res.status(200).json(result);
      })
      .catch(err => {
        console.log(err);
        res.status(401).json({ errors });
      });
}

const Developpements = async (req, res) => {
  try {
    const userId  = req.params.userId;
    const vaccin = await Developpement.find({ user: userId }).sort({ date: 1 }).select('-__v -_id -user');
    if (!vaccin) {
      return res.status(404).json({ status: false, message: "No Vaccin found for the user" });
    }
    res.status(200).json({ status: true, vaccin }); 
  } catch (error) {
    console.log(error, 'err---->');
    res.status(500).json({ status: false, message: "Internal server error" });
  }
};
const createautresInfo = async (req, res) => {
  const vaccin = new AutresInfo(req.body);
  vaccin.save()
    .then(result => {
      res.status(200).json(result);
    })
    .catch(err => {
      console.log(err);
      res.status(401).json({ errors });
    });
}
const autresInfo = async (req, res) => {
  try {
    const userId  = req.params.userId;
    const vaccin = await AutresInfo.find({ user: userId }).sort({ date: 1 }).select('-__v -_id -user');
    if (!vaccin) {
      return res.status(404).json({ status: false, message: "No Vaccin found for the user" });
    }
    res.status(200).json({ status: true, vaccin }); 
  } catch (error) {
    console.log(error, 'err---->');
    res.status(500).json({ status: false, message: "Internal server error" });
  }
};
const createConsultation = async (req, res) => {
  const consultation = new Consultation(req.body);
  consultation.save()
    .then(result => {
      res.status(200).json(result);
    })
    .catch(err => {
      console.log(err);
      res.status(401).json({ errors });
    });
}
const getConsultation = async (req, res) => {
  try {
    const userId  = req.params.userId;
    const consultation = await Consultation.find({ user: userId }).sort({ date: 1 }).select('-__v -_id -user');
    if (!consultation) {
      return res.status(404).json({ status: false, message: "No Consultation found for the user" });
    }
    res.status(200).json({ status: true, consultation }); 
  } catch (error) {
    console.log(error, 'err---->');
    res.status(500).json({ status: false, message: "Internal server error" });
  }
};

module.exports = { getLasteSyring,userInfo,createSyring,vaccinations,createDeveloppement,Developpements,createautresInfo,autresInfo,createConsultation,getConsultation}