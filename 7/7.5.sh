/home/conan/hadoop/hadoop-1.1.2/bin/start-all.sh
/home/conan/hadoop/hbase-0.94.2/bin/start-hbase.sh
/home/conan/hadoop/hbase-0.94.2/bin/hbase-daemon.sh start thrift

R CMD INSTALL rhbase_1.1.1.tar.gz

/home/conan/hadoop/hbase-0.94.18/bin/hbase shell
> create 'student_shell','info'
> list
> describe 'student_shell'
> put 'student_shell','mary','info:age','19'
> get 'student_shell','mary'
> disable 'student_shell'
> drop 'student_shell'







