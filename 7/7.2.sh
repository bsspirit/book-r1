sudo -i
whoami
R CMD javareconf
export HADOOP_CMD=/root/hadoop/hadoop-1.1.2/bin/hadoop
export HADOOP_STREAMING=/root/hadoop/hadoop-1.1.2/contrib/streaming/hadoop-streaming-1.1.2.jar

R CMD INSTALL /root/R/rhdfs_1.0.5.tar.gz
R CMD INSTALL /root/R /rmr2_2.1.0.tar.gz

hadoop fs -ls /user
hadoop fs -cat /user/hdfs/o_same_school/part-m-00000




