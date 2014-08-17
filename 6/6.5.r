install.packages("rJava")
install.packages("RHive")
library(RHive)

rhive.init()
rhive.connect("192.168.1.210")
rhive.list.tables()
rhive.desc.table('o_account')
rhive.query("select * from o_account")
rhive.close()

rhive.block.sample('o_account', subset="id<5")
rhive.query("select * from rhive_sblk_1372238856")
rhive.hdfs.ls('/user/hive/warehouse/rhive_sblk_1372238856/')
rhive.hdfs.cat('/user/hive/warehouse/rhive_sblk_1372238856/000000_0')

rhive.basic.cut('o_account','id',breaks='0:100:3')
rhive.query("select * from rhive_result_20130626173626");
rhive.hdfs.ls()
rhive.hdfs.cat('/user/hive/warehouse/o_account/part-m-00000')

