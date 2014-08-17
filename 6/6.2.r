install.packages("rmongodb")
library(rmongodb)
mongo<-mongo.create(host="192.168.1.199")
print(mongo.is.connected(mongo))

db<-"foobar" 
ns<-"foobar.blog" 

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.append(buf, "name", "Echo")
mongo.bson.buffer.append(buf, "age", 22L)
mongo.bson.buffer.append(buf, "gender", 'Male')

score <- c(5, 3.5, 4)
names(score) <- c("Mike", "Jimmy", "Ann")
mongo.bson.buffer.append(buf, "score", score)

mongo.bson.buffer.start.array(buf, "comments")
mongo.bson.buffer.append(buf, "0", "a1")
mongo.bson.buffer.append(buf, "1", "a2")
mongo.bson.buffer.append(buf, "2", "a3")
mongo.bson.buffer.finish.object(buf)
b <- mongo.bson.from.buffer(buf)

mongo.insert(mongo,ns,b)

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.append(buf, "name", "Echo")
query <- mongo.bson.from.buffer(buf)
print(mongo.find.one(mongo, ns, query))

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.start.object(buf, "$inc")
mongo.bson.buffer.append(buf, "age", 1L)
mongo.bson.buffer.finish.object(buf)
objNew <- mongo.bson.from.buffer(buf)
mongo.update(mongo, ns, query, objNew)
print(mongo.find.one(mongo, ns, query))

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.start.object(buf, "$set")
mongo.bson.buffer.append(buf, "age", 1L)
mongo.bson.buffer.finish.object(buf)
objNew <- mongo.bson.from.buffer(buf)
mongo.update(mongo, ns, query, objNew)
print(mongo.find.one(mongo, ns, query))

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.start.object(buf, "$push")
mongo.bson.buffer.append(buf, "comments", "Orange")
mongo.bson.buffer.finish.object(buf)
objNew <- mongo.bson.from.buffer(buf)
mongo.update(mongo, ns, query, objNew)
print(mongo.find.one(mongo, ns, query))

mongo.update(mongo, ns, query, list(name="Echo", age=25))
print(mongo.find.one(mongo, ns, query))

mongo.remove(mongo, ns, query)  
mongo.destroy(mongo)  

library(stringr)  
batch_insert<-function(arr=1:10,ns){   
   mongo_insert<-function(x){
      buf <- mongo.bson.buffer.create()
      mongo.bson.buffer.append(buf, "name", str_c("Dave",x))
      mongo.bson.buffer.append(buf, "age", x)
      mongo.bson.buffer.start.array(buf, "comments")
      mongo.bson.buffer.append(buf, "0", "a1")
      mongo.bson.buffer.append(buf, "1", "a2")
      mongo.bson.buffer.append(buf, "2", "a3")
      mongo.bson.buffer.finish.object(buf)
      return(mongo.bson.from.buffer(buf))
   }
   mongo.insert.batch(mongo, ns, lapply(arr,mongo_insert))
}

batch_inc<-function(data,ns){
    for(i in data){
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.append(buf, "name", str_c("Dave",i))
       criteria <- mongo.bson.from.buffer(buf)
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.start.object(buf, "$inc")
       mongo.bson.buffer.append(buf, "age", 1L)
       mongo.bson.buffer.finish.object(buf)
       objNew <- mongo.bson.from.buffer(buf)
       mongo.update(mongo, ns, criteria, objNew)
    }
}
batch_set<-function(data,ns){
    for(i in data){
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.append(buf, "name", str_c("Dave",i))
       criteria <- mongo.bson.from.buffer(buf)
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.start.object(buf, "$set")
       mongo.bson.buffer.append(buf, "age", 1L)
       mongo.bson.buffer.finish.object(buf)
       objNew <- mongo.bson.from.buffer(buf)
       mongo.update(mongo, ns, criteria, objNew)
    }
}

batch_push<-function(data,ns){
    for(i in data){
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.append(buf, "name", str_c("Dave",i))
       criteria <- mongo.bson.from.buffer(buf)
       buf <- mongo.bson.buffer.create()
       mongo.bson.buffer.start.object(buf, "$push")
       mongo.bson.buffer.append(buf, "comments", "Orange")
       mongo.bson.buffer.finish.object(buf)
       objNew <- mongo.bson.from.buffer(buf)
       mongo.update(mongo, ns, criteria, objNew)
    }
}

ns="foobar.blog"
data=1:1000
mongo.remove(mongo, ns)
system.time(batch_insert(data, ns))
system.time(batch_inc(data, ns))
system.time(batch_set(data, ns))
system.time(batch_push(data, ns))