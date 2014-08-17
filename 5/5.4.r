install.packages("websockets")
library(websockets)
demo(websockets)

text = "<html><body><h1>Hello world</h1></body></html>"
w = create_server(port=7681,webpage=static_text_service(text))
recv = function(DATA, WS, ...){   ## 监听receive
  cat("Receive callback\n")
  D = ""
  if(is.raw(DATA)){D = rawToChar(DATA)}
  cat("Callback:You sent",D,"\n")
  websocket_write(DATA=paste("You sent",D,"\n",collapse=" "),WS=WS)
}
set_callback('receive',recv,w)
cl = function(WS){   ## 监听closed
  cat("Websocket client socket ",WS$socket," has closed.\n")
}
set_callback('closed',cl,w)

es = function(WS){
  cat("Websocket client socket ",WS$socket," has been established.\n")
}
set_callback('established',es,w)
while(TRUE) service(w)

library(websockets)
client = websocket("ws://192.168.1.201",port=7681)
rece<-function(DATA, WS, HEADER) { +   D='' +   if(is.raw(DATA)){ +     cat("raw data") +     D = rawToChar(DATA) +   } +   cat("==>",D,"\n")}
set_callback("receive",rece, client)
websocket_write("2222", client)
service(client)
websocket_close(client)