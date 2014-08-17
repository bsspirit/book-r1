sudo apt-get install r-base-core
R --version

sudo apt-get autoremove r-base-core

sudo sh -c "echo deb http://mirror.bjtu.edu.cn/cran/bin/linux/ubuntu precise/ >>/etc/apt/sources.list"
sudo apt-get update
sudo apt-get install r-base-core
sudo apt-get install r-base-core=2.15.3-1precise0precise1
sudo apt-get install r-base-core=3.0.1-6precise0