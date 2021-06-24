var ws = require('ws')

var server = new ws.Server({ port: 3333 })

server.on('connection', (client) => {
    client.on('message', (message) => {
        let data = JSON.parse(message)
        console.log(data)
    })
    client.on('close', (message) => {
        console.log(code, message)
    })

    client.send(JSON.stringify({'test': 'test'}))
})