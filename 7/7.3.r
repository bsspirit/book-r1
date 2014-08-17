library(rhdfs)
library(rmr2)

data<-read.table(file="hadoop15.txt")
d0<-to.dfs(keyval(1, data))
from.dfs(d0)

mr<-function(input=d0){
    map<-function(k,v){
        keyval(word(as.character(v$V1), 2, sep = fixed('@')),1)
    }
    reduce =function(k, v ) {
        keyval(k, sum(v))
    }
    d1<-mapreduce(input=input,map=map,reduce=reduce,combine=TRUE)
 }
d1<-mr(d0)
from.dfs(d1)

sort<-function(input=d1){
    map<-function(k,v){
        keyval(1,data.frame(k,v))
    }
    reduce<-function(k,v){
        v2<-v[order(as.integer(v$v),decreasing=TRUE),]
        keyval(1,v2)
    }
    d2<-mapreduce(input=input,map=map,reduce=reduce,combine=TRUE)
 }
d2<-sort(d1)
result<-from.dfs(d2)
result$val
