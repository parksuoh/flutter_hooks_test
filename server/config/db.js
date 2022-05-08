const mysql = require('mysql')

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '1234567',
    port: 3306,
    database: 'suohpopol'
})


db.connect(function(err) {
    if (err) throw err
    console.log('MYSQL 연결됨')
})

module.exports = db