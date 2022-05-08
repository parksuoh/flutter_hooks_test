const { response } = require('express')
const express = require('express')
const app = express()

const server = require('http').createServer(app)
const io = require('socket.io')(server) 

const db = require('./config/db');

const PORT = 4000

const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')

app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())



app.use('/api/user', require('./route/user'));
app.use('/api/board', require('./route/board'));
// app.use('/api/chat', require('./route/chat'));


io.on('connection', (socket) => {

    console.log('소켓 연결됨')

    socket.on('message', (msgData) => {
        console.log('메세지:' + msgData)

        // db.query('call INS_CHAT(?, ?)', [parsInt(msgData['UID']), msgData['text']], (err, result) => {
        //     if(err) throw err
    
        //     socket.broadcast.emit("receive-message", msgData)
    
        // })
        
    })

    socket.on('disconnect', () => {
        console.log('disconnect')
    })

})



server.listen(PORT, () => console.log(`연결됨 ${PORT}`))