Rprof
bidpx1<-read.csv(file="000000_0.txt",header=FALSE)
names(bidpx1)<-c("tradedate","tradetime","securityid","bidpx1","bidsize1","offerpx1","offersize1")
bidpx1$securityid<-as.factor(bidpx1$securityid)
head(bidpx1)
object.size(bidpx1)

library(plyr)
fun1<-function(){
    datehour<-paste(bidpx1$tradedate,substr(bidpx1$tradetime,1,2),sep="")
    df<-cbind(datehour,bidpx1[,3:5])
    ddply(bidpx1,.(securityid,datehour),summarize,price=mean(bidpx1),size=sum(bidsize1))
}
head(fun1())
system.time(fun1())

file<-"fun1_rprof.out"
Rprof(file)
fun1()
Rprof(NULL)
summaryRprof(file)

install.packages("stockPortfolio")
library(stockPortfolio)
fileName <- "Rprof2.log"
Rprof(fileName)
gr <- getReturns(c("GOOG", "MSFT", "IBM"), freq="week")
gr
Rprof(NULL)
summaryRprof(fileName)$by.total[1:8,]

install.packages("profr")
library(profr)
library(ggplot2)
file<-"fun1_rprof.out"plot(parse_rprof(file))
ggplot(parse_rprof(file))
fileName <- "Rprof2.log"
plot(parse_rprof(fileName))
ggplot(parse_rprof(fileName))

