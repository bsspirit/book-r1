/etc/init.d/redis-server start
ps -aux|grep redis
cat /var/log/redis/redis-server.log

redis-cli
redis 127.0.0.1:6379> help set
redis 127.0.0.1:6379> set a 178
redis 127.0.0.1:6379> get a
redis 127.0.0.1:6379> keys

















