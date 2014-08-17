install.packages("rjson")
library(rjson)

json_data <- fromJSON(paste(readLines("fin0.json"), collapse=""))
json_data
class(json_data)
class(json_data$table2)
class(json_data$table2$data)
class(json_data$table2$data$jtid)
class(json_data$table1$data$code)
json_data$table1$data$code
json_data$table1$data$code[1]

json_str<-toJSON(json_data)
print(json_str)
cat(json_str)

writeLines(json_str, "fin0_out1.json")

sink("fin0_out2.json")
cat(json_str)
sink()

system.time( y <- fromJSON(json_str,method="C") )
system.time( y2 <- fromJSON(json_str,method = "R") )
system.time( y3 <- fromJSON(json_str) )

system.time( y <- toJSON(json_data,method="C") )
system.time( y2 <- toJSON(json_data,method = "R") )
system.time( y3 <- toJSON(json_data) )

install.packages("RJSONIO")
library(RJSONIO)

json_data <- fromJSON(paste(readLines("fin0.json"), collapse=""))
json_data
json_data$table1$data$code
json_data$table1$data$code[1]

json_str<-toJSON(json_data)
print(json_str)
cat(json_str)

writeLines(json_str, "fin0_io.json")

isValidJSON(json_str)
isValidJSON(json_str,TRUE)
isValidJSON(I('{"foo" : "bar"}'))
isValidJSON(I('{foo : "bar"}'))

cat(asJSVars( a = 1:10, myMatrix = matrix(1:15, 3, 5)))

df<-data.frame(
  code=c('TF1312','TF1310','TF1313'),
  rt_time=c("152929","152929","152929"),
  rt_latest=c(93.76,93.76,93.76),
  rt_bid1=c(93.76,93.76,93.76),
  rt_ask1=c(90.76,90.76,90.76),
  rt_bsize1=c(2,3,1),
  rt_asize1=c(100,1,11),
  optionValue=c(-0.4,0.2,-0.1),
  diffValue=c(0.6,0.6,0.5)
)
df
cat(toJSON(df))

library(plyr)
cat(toJSON(unname(alply(df, 1, identity))))

df<-data.frame(
   a=rep(letters,10000),
   b=rnorm(260000),
   c=as.factor(Sys.Date()-rep(1:260000))
)
system.time(rjson::toJSON(df))
system.time(RJSONIO::toJSON(df))
system.time(rjson::toJSON(unname(alply(df, 1, identity))))
system.time(RJSONIO::toJSON(unname(alply(df, 1, identity))))