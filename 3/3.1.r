install.packages("memoise")
library(memoise)

fun <- memoise(function(x) { Sys.sleep(1); runif(1) })
system.time(print(fun()))
system.time(print(fun()))
forget(fun)
system.time(print(fun()))
system.time(print(fun()))











