R CMD Rserve
ps -aux|grep Rserve
netstat -nltp|grep Rserve
R CMD Rserve --RS-enable-remote