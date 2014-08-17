install.packages("RSclient")
library(RSclient)

conn<-RS.connect(host="192.168.1.201")
RS.login(conn,"conan","conan",authkey=RS.authkey(conn))

RS.eval(conn,rnorm(5))
RS.assign(conn,"xx",99)
RS.eval(conn,xx-55)

RS.eval(conn,head(rnorm(10000000)),wait=TRUE)
RS.eval(conn,head(rnorm(10000000)),wait=FALSE)
RS.collect(conn)

RS.close(conn)

conn<-RS.connect(host="192.168.1.201")
RS.login(conn,"conan","conan",authkey=RS.authkey(conn))
RS.assign(conn,"A",1234)
RS.eval(conn,A)
RS.eval(conn,ls())
RS.eval(conn,getwd())

conn<-RS.connect(host="192.168.1.201")
RS.login(conn,"conan","conan",authkey=RS.authkey(conn))
RS.assign(conn,"B",5678)
RS.eval(conn,B)
RS.eval(conn,ls())
RS.eval(conn,getwd())

