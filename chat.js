var fs=require('fs');
var history=fs.readFileSync('index.txt')+'\n';              // Load message history from log
var app=fs.readFileSync('chat.htm');
var s=require('http').createServer(function(req,res){
    res.writeHead(200); res.end(app);                       // Serve static client app
}).listen(4321);
var conns=[];
var w=new(require('websocket').server)({httpServer:s}).on('request',function(r){
    var c=r.accept(r.protocol,r.origin); conns.push(c);     // Add connection for fan out
    c.sendUTF(history);                                     // On join, send full message history
    c.on('message',function(m){
        var fm=(new Date).toLocaleString()+' '+m.utf8Data;  // On message, add server timestamp
        for(x in conns)conns[x].sendUTF(fm);                // Fan out to other connections
        history+=fm+'\n';                                   // Update message history in memory
        fs.appendFile('index.txt',fm+'\n');                 // Append to message log file
    });
});
