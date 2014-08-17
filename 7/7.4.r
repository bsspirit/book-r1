# 单机算法
library(plyr)
train<-read.csv(file="small.csv",header=FALSE)
names(train)<-c("user","item","pref")
usersUnique<-function(){
    users<-unique(train$user)
    users[order(users)]
}
itemsUnique<-function(){
    items<-unique(train$item)
    items[order(items)]
}
users<-usersUnique()
items<-itemsUnique()
index<-function(x) which(items %in% x)
data<-ddply(train,.(user,item,pref),summarize,idx=index(item))
cooccurrence<-function(data){
    n<-length(items)
    co<-matrix(rep(0,n*n),nrow=n)
    for(u in users){
        idx<-index(data$item[which(data$user==u)])
        m<-merge(idx,idx)
        for(i in 1:nrow(m)){
            co[m$x[i],m$y[i]]=co[m$x[i],m$y[i]]1
        }
    }
    return(co)
}
recommend<-function(udata=udata,co=coMatrix,num=0){
    n<-length(items)
    pref<-rep(0,n)
    pref[udata$idx]<-udata$pref
    userx<-matrix(pref,nrow=n)
    r<-co %*% userx
    r[udata$idx]<-0
    idx<-order(r,decreasing=TRUE)
    topn<-data.frame(user=rep(udata$user[1],length(idx)),item=items[idx],val=r[idx])
    topn<-topn[which(topn$val>0),]
    if(num>0){
        topn<-head(topn,num)
    }
    return(topn)
}
co<-cooccurrence(data)
recommendation<-data.frame()
for(i in 1:length(users)){
    udata<-data[which(data$user==users[i]),]
    recommendation<-rbind(recommendation,recommend(udata,co,0))
}
recommendation

# 分布式算法
library(rmr2)
train<-read.csv(file="small.csv",header=FALSE)
names(train)<-c("user","item","pref")
rmr.options(backend = 'hadoop')
train.hdfs = to.dfs(keyval(train$user,train))
from.dfs(train.hdfs)

train.mr<-mapreduce(
  train.hdfs,
  map = function(k, v) {
    keyval(k,v$item)
  }
  ,reduce=function(k,v){
    m<-merge(v,v)
    keyval(m$x,m$y)
  }
 )
from.dfs(train.mr)

step2.mr<-mapreduce(
  train.mr,
  map = function(k, v) {
    d<-data.frame(k,v)
    d2<-ddply(d,.(k,v),count)

    key<-d2$k
    val<-d2
    keyval(key,val)
  }
)
from.dfs(step2.mr)

train2.mr<-mapreduce(
  train.hdfs,
  map = function(k, v) {
    #df<-v[which(v$user==3),]
    df<-v
    key<-df$item
    val<-data.frame(item=df$item,user=df$user,pref=df$pref)
    keyval(key,val)
  }
)
from.dfs(train2.mr)

eq.hdfs<-equijoin(
  left.input=step2.mr,
  right.input=train2.mr,
  map.left=function(k,v){
    keyval(k,v)
  },
  map.right=function(k,v){
    keyval(k,v)
  },
  outer = c("left")
)
from.dfs(eq.hdfs)

cal.mr<-mapreduce(
  input=eq.hdfs,
  map=function(k,v){
    val<-v
    na<-is.na(v$user.r)
    if(length(which(na))>0) val<-v[-which(is.na(v$user.r)),]
    keyval(val$k.l,val)
  }
  ,reduce=function(k,v){
    val<-ddply(v,.(k.l,v.l,user.r),summarize,v=freq.l*pref.r)
    keyval(val$k.l,val)
  }
)
from.dfs(cal.mr)

result.mr<-mapreduce(
  input=cal.mr,
  map=function(k,v){
    keyval(v$user.r,v)
  }
  ,reduce=function(k,v){
    val<-ddply(v,.(user.r,v.l),summarize,v=sum(v))
    val2<-val[order(val$v,decreasing=TRUE),]
    names(val2)<-c("user","item","pref")
    keyval(val2$user,val2)
  }
)
from.dfs(result.mr)



