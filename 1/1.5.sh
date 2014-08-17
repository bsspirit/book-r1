sudo apt-get install gdebi-core
sudo apt-get install libapparmor1  # Required only for Ubuntu, not Debian
wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
sudo gdebi rstudio-server-0.97.551-amd64.deb

ps -aux|grep rstudio-server

vi /etc/rstudio/rserver.conf
vi /etc/rstudio/rsession.conf

sudo rstudio-server start
sudo rstudio-server stop
sudo rstudio-server restart

sudo rstudio-server active-sessions
sudo  rstudio-server suspend-session 6817
sudo rstudio-server suspend-all
sudo rstudio-server force-suspend-session 6817
sudo rstudio-server force-suspend-all

sudo rstudio-server offline
sudo rstudio-server online

sudo groupadd hadoop
sudo useradd hadoop -g hadoop
sudo passwd hadoop
sudo adduser hadoop sudo
sudo mkdir /home/hadoop
sudo chown -R hadoop:hadoop /home/hadoop

ssh hadoop@localhost
pwd

sudo apt-get install git
ssh-keygen -t rsa
cat /home/conan/.ssh/id_rsa.pub

mkdir /home/conan/R/github
cd /home/conan/R/github
git init
git add .
git commit -m 'first comment'
git remote add origin git@github.com:bsspirit/rstudio-demo.git
git push -u origin master   # 上传本地git库中的代码到github



