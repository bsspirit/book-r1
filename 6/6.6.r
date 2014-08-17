> library(RHive)
> rhive.init()
> rhive.connect("c1.wtmart.com")

> rhive.list.tables()
> rhive.query("SHOW PARTITIONS t_hft_day");

> rhive.drop.table("t_reverse_repurchase")
> rhive.query("CREATE TABLE t_reverse_repurchase AS SELECT tradedate,tradetime,securityid,bidpx1,bidsize1,offerpx1,offersize1 FROM t_hft_day where tradedate>=20130722 and securityid in (131810,204001)");
> rhive.query("SELECT securityid,count(1) FROM t_reverse_repurchase group by securityid");
> bidpx1<-rhive.query("SELECT securityid,concat(tradedate,tradetime) as tradetime,bidpx1 FROM t_reverse_repurchase"); #查看记录条数 > nrow(bidpx1)
> head(bidpx1)

> library(ggplot2)
> g<-ggplot(data=bidpx1, aes(x=as.POSIXct(tradetime,format="%Y%m%d%H%M%S"), y=bidpx1))
> g<-g+geom_line(aes(group=securityid,colour=securityid))
> g<-g+xlab('tradetime')+ylab('bidpx1')
> ggsave(g,file="01.png",width=12,height=8)

> bidpx1<-rhive.query("SELECT securityid,concat(tradedate,tradetime) as tradetime,bidpx1 FROM t_reverse_repurchase WHERE tradedate=20130726");
> g<-ggplot(data=bidpx1, aes(x=as.POSIXct(tradetime,format="%Y%m%d%H%M%S"), y=bidpx1))
> g<-g+geom_line(aes(group=securityid,colour=securityid))
> g<-g+xlab('tradetime')+ylab('bidpx1')
> ggsave(g,file="02.png",width=12,height=8)


library(ggplot2)
library(scales)
library(plyr)
bidpx1<-rhive.query(paste("SELECT securityid,tradedate,tradetime,bidpx1 FROM t_reverse_repurchase WHERE tradedate>=20130722"));
oneDay<-function(date){
  d1<-bidpx1[which(bidpx1$tradedate==date),]
  d1$tradetime2<-round( as.numeric(as.character(d1$tradetime))/100)*100
  d1$tradetime2[which(d1$tradetime2<100000)]<-paste(0,d1$tradetime2[which(d1$tradetime2<100000)],sep="")
  d1$tradetime2[which(d1$tradetime2=='1e+05')]='100000'
  d1$tradetime2[which(d1$tradetime2=='096000')]='100000'
  d1$tradetime2[which(d1$tradetime2=='106000')]='110000'
  d1$tradetime2[which(d1$tradetime2=='126000')]='130000'
  d1$tradetime2[which(d1$tradetime2=='136000')]='140000'
  d1$tradetime2[which(d1$tradetime2=='146000')]='150000'
  d1
}
meanScale<-function(d1){
  ddply(d1, .(securityid,tradetime2), summarize, bidpx1=mean(bidpx1))
}
findPoint<-function(a1,a2){
  bigger_point<-function(a1,a2){
    idx<-c()
    for(i in intersect(a1$tradetime2,a2$tradetime2)){
      i1<-which(a1$tradetime2==i)
      i2<-which(a2$tradetime2==i)
      if(a1$bidpx1[i1]-a2$bidpx1[i2]>=-0.02){
        idx<-c(idx,i1)
      }
    }
    idx
  }
  remove_continuous_point<-function(idx){
    idx[-which(idx-c(NA,rev(rev(idx)[-1]))==1)]
  }
  idx<-bigger_point(a1,a2)
  remove_continuous_point(idx)
}
findOptimize<-function(d3){
  idx2<-which((d3$bidpx1-c(NA,rev(rev(d3$bidpx1)[-1])))/d3$bidpx1>0.1)
  if(length(idx2)<1)
    print("No Optimize point")
  d3[idx2,]
}
draw<-function(d2,d3,d4,date,png=FALSE){
  g<-ggplot(data=d2, aes(x=strptime(paste(date,tradetime2,sep=""),format="%Y%m%d%H%M%S"), y=bidpx1))
  g<-g+geom_line(aes(group=securityid,colour=securityid))
  g<-g+geom_point(data=d3,aes(size=1.5,colour=securityid))   if(nrow(d4)>0){
    g<-g+geom_text(data=d4,aes(label= format(d4$bidpx1,digits=4)),colour="blue",hjust=0, vjust=0)
  }
  g<-g+xlab('tradetime')+ylab('bidpx1')
  if(png){
    ggsave(g,file=paste(date,".png",sep=""),width=12,height=8)
  }else{
    g
  }
}
date<-20130722
d1<-oneDay(date)
d2<-meanScale(d1)
a1<-d2[which(d2$securityid==131810),]
a2<-d2[which(d2$securityid==204001),]
d3<-d2[findPoint(a1,a2),]
d4<-findOptimize(d3)
draw(d2,d3,d4,as.character(date),TRUE)





