var ws = require('ws')

var server = new ws.Server({ port: 3333 })

server.on('connection', (client) => {
    client.send(JSON.stringify({
        "welcome": true
    }))
    client.on('message', (message) => {
        let data = JSON.parse(message)
        server.broadcast(JSON.stringify({
            'username': data['username'],
            'text': data['text']
        }))
        console.log(data)
    })
    client.on('close', (message) => {
        console.log(message)
    })
})

server.broadcast = function broadcast(msg) {
    server.clients.forEach(function each(client) {
        client.send(msg);
     });
 };