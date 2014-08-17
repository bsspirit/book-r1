var ws = new WebSocket("ws://192.168.1.201:7681");
ws.onopen = function(){
    console.log("connecting");
};
ws.onmessage = function(message){
    console.log(message.data);
    console.log(message);
};
function postToServer(msg){
    ws.send(msg);
}
function closeConnect(){
    ws.close();
    console.log("closed");
}

postToServer('browser');
closeConnect();
