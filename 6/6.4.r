install.packages('RCassandra')
library(RCassandra)
conn<-RC.connect(host="192.168.1.200")

RC.cluster.name(conn)
RC.version(conn)

RC.describe.keyspaces(conn) 
RC.describe.keyspace(conn, "DEMO")

head(iris)
RC.write.table(conn, "iris", iris)
RC.get(conn, "iris", "1", c("Sepal.Length", "Species"))
RC.get.range(conn, "iris", "1")
r <- RC.get.range.slices(conn, "iris")
r[[1]]

rk <- RC.get.range.slices(conn, "iris", limit=0)
y <- RC.read.table(conn, "iris")
y <- y[order(as.integer(row.names(y))),]
head(y)

df<-data.frame(name=c('a1','a2'),password=c('a1','a2'))
print(df)
RC.write.table(conn, "Users", df)
RC.read.table(conn,"Users") 
RC.insert(conn,'Users','1234', 'name', 'scott')
RC.insert(conn,'Users','1234', 'password', 'tiger')
RC.insert(conn,'Users','1234', 'age', '20')
RC.read.table(conn,"Users") 
RC.insert(conn,'Users','1', 'name', 'a11')
RC.insert(conn,'Users','1', 'age', '12')
RC.read.table(conn,"Users")  








