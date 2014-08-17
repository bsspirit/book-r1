.libPaths()
install.packages("rJava")
install.packages("reshape2")
install.packages("Rcpp")
install.packages("iterators")
install.packages("itertools")
install.packages("digest")
install.packages("RJSONIO")
install.packages("functional")

library(rmr2)
small.ints = to.dfs(1:10)
mapreduce(input = small.ints, map = function(k, v) cbind(v, v^2))

