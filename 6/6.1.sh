uname -a
cat /etc/issue
locale
mysql --version

sudo apt-get install libdbd-mysql libmysqlclient-dev
whereis mysql
R CMD INSTALL --configure-args='--with-mysql-dir=/usr/lib/mysql' /tmp/Rtmpu0Gn88/downloaded_packages/RMySQL_0.9-3.tar.gz

mysql -uroot –p
mysql> create database rmysql;
mysql> grant all on rmysql.* to rmysql@'%' identified by 'rmysql';
mysql> grant all on rmysql.* to rmysql@localhost identified by 'rmysql';
mysql> use rmysql

mysql> CREATE TABLE t_user(
        id INT PRIMARY KEY AUTO_INCREMENT,
        user varchar(12) NOT NULL UNIQUE
        )ENGINE=INNODB DEFAULT CHARSET=utf8;

mysql> INSERT INTO t_user(user) values('A1'),('AB'),('fens.me');
mysql> SELECT * FROM t_user;
