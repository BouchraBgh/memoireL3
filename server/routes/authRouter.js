const express = require('express');
const router = express.Router();
const authController = require('../controllers/authControllers');

router.post('/createuser', authController.createUser);
router.post('/login', authController.login);
router.post('/getuserData', authController.getuserData);

module.exports = router;