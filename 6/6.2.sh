sudo /etc/init.d/mongodb start
ps -aux|grep mongo
cat /var/log/mongodb/mongodb.log

mongo
> show dbs
> use foobar
> show collections

