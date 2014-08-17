install.packages("rredis")
library(rredis)

redisConnect(host="192.168.1.101",port=6379)
redisKeys()
redisDBSize()
redisSelect(1)
redisKeys()
redisSelect(0)
redisKeys()
redisFlushDB()
redisFlushAll()
redisClose()

redisSet('x',runif(5))
redisGet('x')
redisExpire('x',1)
redisGet('x')

redisMSet(list(x=pi,y=runif(5),z=sqrt(2)))
redisMGet(c('x','y','z'))

redisDelete('x')
redisGet('x')

redisLPush('a',1)
redisLPush('a',2)
redisLPush('a',3)

redisLRange('a',0,2)
redisLPop('a')
redisLRange('a',0,-1)
redisRPush('a','A')
redisRPush('a','B')
redisLRange('a',0,-1)
redisRPop('a')

redisSAdd('A',runif(2))
redisSAdd('A',55)
redisSCard('A')
redisSMembers('A')
redisSAdd('B',55)
redisSAdd('B',rnorm(3))
redisSCard('B')
redisSMembers('B')

redisSDiff(c('A','B'))
redisSInter(c('A','B'))
redisSUnion(c('A','B'))

redisSet('R', 'Greetings, shell client!')
redisSet('R', charToRaw('Greetings, shell client!'))

data<-scan(file="data5.txt",what=character(),sep=" ") 
data<-data[which(data!='#')]
data
redisConnect(host="192.168.1.101",port=6379) 
redisFlushAll()
redisKeys()
id<-NULL
for(i in 1:length(data)){
  if(i %% 3 == 1) {
    id<-data[i]
    redisSAdd(paste("users:",id,sep=""),paste("id:",id,sep=""))
  } else if(i %% 3 == 2) {
    redisSAdd(paste("users:",id,sep=""),paste("pw:",data[i],sep=""))
  } else {
    redisSAdd(paste("users:",id,sep=""),paste("email:",data[i],sep=""))
  }
}
redisKeys()
redisSMembers("users:wolys")
redisClose()



