library(websockets)
client = websocket("ws://192.168.1.201",port=7681)

rece<-function(DATA, WS, HEADER) {   D=''   if(is.raw(DATA)){     cat("raw data")     D = rawToChar(DATA)   }   cat("==>",D,"\n")}
set_callback("receive",rece, client)

websocket_write("2222", client)

service(client)

websocket_close(client)
