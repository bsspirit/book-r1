sudo R CMD javareconf
sudo R

mkdir /home/conan/R/DemoRJava
cd /home/conan/R/DemoRJava
export R_HOME=/usr/lib/R
java -Djava.library.path=/usr/local/lib/R/site-library/rJava/jri -cp /usr/local/lib/R/site-library/rJava/jri/JRI.jar:/home/conan/R/DemoRJava/DemoRJava.jar org.conan.r.rjava.DemoRJava
