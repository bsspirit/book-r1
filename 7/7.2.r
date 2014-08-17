install.packages("rJava")
install.packages("reshape2")
install.packages("Rcpp")
install.packages("iterators")
install.packages("itertools")
install.packages("digest")
install.packages("RJSONIO")
install.packages("functional")

library(rhdfs)
hdfs.init()
hdfs.ls("/user/")
hdfs.cat("/user/hdfs/o_same_school/part-m-00000")

library(rmr2)
small.ints = 1:10
sapply(small.ints, function(x) x^2)
small.ints = to.dfs(1:10)
mapreduce(input = small.ints, map = function(k, v) cbind(v, v^2))
from.dfs("/tmp/RtmpWnzxl4/file5deb791fcbd5")

input<- '/user/hdfs/o_same_school/part-m-00000'
wordcount = function(input, output = NULL, pattern = " "){
    wc.map = function(., lines) {
            keyval(unlist( strsplit( x = lines,split = pattern)),1)
    }
    wc.reduce =function(word, counts ) {
            keyval(word, sum(counts))
    }
    mapreduce(input = input ,output = output, input.format = "text", map = wc.map, reduce = wc.reduce,combine = T)
}
wordcount(input)
from.dfs("/tmp/RtmpfZUFEa/file6cac626aa4a7")


