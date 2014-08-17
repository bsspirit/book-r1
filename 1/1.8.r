install.packages("caTools")
library(caTools)

write.gif(volcano, "volcano.gif", col=terrain.colors, flip=TRUE, scale="always", comment="Maunga Whau Volcano")

y = read.gif("volcano.gif", verbose=TRUE, flip=TRUE)
attributes(y)
class(y$image)
ncol(y$image)
nrow(y$image)
head(y$col,10)
y$comment
image(y$image, col=y$col, main=y$comment, asp=1)

x <- y <- seq(-4*pi, 4*pi, len=200)
r <- sqrt(outer(x^2, y^2, "+"))
image = array(0, c(200, 200, 10))
for(i in 1:10) image[,,i] = cos(r-(2*pi*i/10))/(r^.25)
write.gif(image, "wave.gif", col="rainbow")
y = read.gif("wave.gif")
for(i in 1:10) image(y$image[,,i], col=y$col, breaks=(0:256)-0.5, asp=1)

size=1
x = (10*runif(10)>5)
y = base64encode(x, size=size)
z = base64decode(y, typeof(x), size=size)
x;y;z

x = "Hello R!!" # character
y = base64encode(x)
z = base64decode(y, typeof(x))
x;y;z

# 错误测试
data(iris)
class(iris)
head(x)
base64encode(x)

library(MASS)
data(cats)
head(cats)
colAUC(cats[,2:3], cats[,1], plotROC=TRUE)

combs(2:5, 3)
combs(c("cats", "dogs", "mice"), 2)
a = combs(1:4, 2)
a
b = matrix( c(1,1,1,2,2,3,2,3,4,3,4,4), 6, 2)
b

x = (1:10)*pi/10
trapz(x, sin(x))
x = (1:1000)*pi/1000
trapz(x, sin(x))

head(iris)
Data = iris[,-5]
Label = iris[, 5]
model = LogitBoost(Data, Label, nIter=20)
model
Lab = predict(model, Data)
Prob = predict(model, Data, type="raw")
t = cbind(Lab, Prob)
head(t)
table(predict(model, Data, nIter= 2), Label)
table(predict(model, Data, nIter=10), Label)
table(predict(model, Data), Label)
mask = sample.split(Label)
length(which(mask))
length(which(!mask))
model = LogitBoost(Data[mask,], Label[mask], nIter=10)
table(predict(model, Data[!mask,], nIter=2), Label[!mask])
table(predict(model, Data[!mask,]), Label[!mask])

BJsales
plot(BJsales,col="black", lty=1,lwd=1, main = "Moving Window Means")
lines(runmean(BJsales, 3), col="red", lty=2, lwd=2)
lines(runmean(BJsales, 8), col="green", lty=3, lwd=2)
lines(runmean(BJsales,15), col="blue", lty=4, lwd=2)
lines(runmean(BJsales,24), col="magenta", lty=5, lwd=2)
lines(runmean(BJsales,50), col="cyan", lty=6, lwd=2)

n=200;k=25
set.seed(100)
x = rnorm(n,sd=30) + abs(seq(n)-n/4)
plot(x, main = "Moving Window Analysis Functions (window size=25)")
lines(runmin (x,k), col="red",lty=1, lwd=1)
lines(runmax (x,k), col="cyan",lty=1, lwd=1)
lines(runmean(x,k), col="blue",lty=1, lwd=1)
lines(runmed (x,k), col="green",lty=2, lwd=2)

x = c(1, 1e20, 1e40, -1e40, -1e20, -1)
a = sum(x); print(a)
b = sumexact(x); print(b)
a = cumsum(x); print(a)
b = cumsumexact(x); print(b)