install.packages('RMySQL')
library(RMySQL)

conn <- dbConnect(MySQL(), dbname = "rmysql", username="rmysql", password="rmysql")
users = dbGetQuery(conn, "SELECT * FROM t_user")
users
dbDisconnect(conn)

conn <- dbConnect(MySQL(), dbname = "rmysql", username="rmysql",password="rmysql",host="192.168.1.201",port=3306)
dbDisconnect(conn)
dbListTables(conn)
dbListFields(conn, "t_user")
summary(MySQL(), verbose = TRUE)
summary(conn, verbose = TRUE)
dbListConnections(MySQL())

t_demo<-data.frame(a=seq(1:10),b=letters[1:10],c=rnorm(10))
dbWriteTable(conn, "t_demo", t_demo)
dbReadTable(conn, "t_demo")

dbWriteTable(conn, "t_demo", t_demo, append=TRUE)
dbWriteTable(conn, "t_demo", t_demo, overwrite=TRUE)

d0 <- dbGetQuery(conn, "SELECT * FROM t_demo where c>0")
class(d0)
d0

rs <- dbSendQuery(conn, "SELECT * FROM t_demo where c>0")
class(rs)
d1 <- fetch(rs, n = 3)
d1
summary(rs, verbose = TRUE)

dbWriteTable(conn, "t_demo", t_demo,row.names=FALSE,overwrite=TRUE)
dbGetQuery(conn, "SELECT * FROM t_demo where c>0")

if(dbExistsTable(conn,'t_demo')){
     dbRemoveTable(conn, "t_demo")
}

query<-dbSendQuery(conn, "show tables")
data <- fetch(query, n = -1)
data

dbDisconnect(conn)
conn <- dbConnect(MySQL(), dbname = "rmysql", username="root", password="",client.flag=CLIENT_MULTI_STATEMENTS)
dbSendQuery(conn,'SET NAMES gbk')
query<-dbSendQuery(conn, "SELECT * FROM t_user")
data <- fetch(query, n = -1)
mysqlCloseResult(query)
data