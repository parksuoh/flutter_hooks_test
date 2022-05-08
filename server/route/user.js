const express = require('express');
const db = require('../config/db');
const router = express.Router();


router.post('/login', (req, res) => {
    let email = req.body.email
    let pass = req.body.pass


    db.query('call SEL_USER(?, ?)', [email, pass], (err, result) => {
        if(err) throw err

        res.send(result[0])

    })

})

router.post('/register', (req, res) => {
    let email = req.body.email
    let pass = req.body.pass
    let nickname = req.body.nickname

    db.query('call INS_USER(?, ?, ?)', [email, pass, nickname], (err, result) => {
        if(err) throw err

        res.send(result[0])

    })
    

})



module.exports = router;