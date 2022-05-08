const express = require('express');
const db = require('../config/db');
const router = express.Router();


router.get('/boardlist', (req, res) => {

    db.query('call SEL_BOARDS_LIST()', (err, result) => {
        if(err) throw err

        res.send(result[0])

    })

})



module.exports = router;