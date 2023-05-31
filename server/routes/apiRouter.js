const express = require('express');
const router = express.Router();
const apiController = require('../controllers/apiController');

router.get('/userInfo/:userId', apiController.userInfo);
router.get('/getLasteSyring/:userId', apiController.getLasteSyring);
router.post('/createSyring', apiController.createSyring);
router.get('/Vaccinations/:userId', apiController.vaccinations);
router.post('/createDeveloppement', apiController.createDeveloppement);
router.get('/Developpements/:userId', apiController.Developpements);
router.post('/createautresInfo', apiController.createautresInfo);
router.get('/autresInfo/:userId', apiController.autresInfo);
router.post('/createConsultation', apiController.createConsultation);
router.get('/getConsultation/:userId', apiController.getConsultation);

module.exports = router;