install.packages("Cairo")
library(Cairo)

Cairo.capabilities()

x<-rnorm(6000)
y<-rnorm(6000)

png(file="plot4.png",width=640,height=480)  # png函数
plot(x,y,col="#ff000018",pch=19,cex=2,main = "plot")
dev.off()

CairoPNG(file="Cairo4.png",width=640,height=480)  # CairoPNG函数
plot(x,y,col="#ff000018",pch=19,cex=2,main = "Cairo")
dev.off()

svg(file="plot-svg4.svg",width=6,height=6)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "plot-svg")
dev.off()

CairoSVG(file="Cairo-svg4.svg",width=6,height=6)
plot(x,y,col="#ff000018",pch=19,cex=2,main = "Cairo-svg")
dev.off()


x <- seq(-10, 10, length= 30)
y <- x
f <- function(x,y) { r <- sqrt(x^2+y^2); 10 * sin(r)/r }
z <- outer(x, y, f)
z[is.na(z)] <- 1

png(file="plot2.png",width=640,height=480)  # PNG图
op <- par(bg = "white", mar=c(0,2,3,0)+.1)
persp(x, y, z,theta = 30, phi = 30,expand = 0.5,col = "lightblue",ltheta = 120,shade = 0.75,ticktype = "detailed",xlab = "X", ylab = "Y", zlab = "Sinc(r)",main = "Plot")
par(op)
dev.off()

CairoPNG(file="Cairo2.png",width=640,height=480)
op <- par(bg = "white", mar=c(0,2,3,0)+.1)
persp(x, y, z,theta = 30, phi = 30,expand = 0.5,col = "lightblue",ltheta = 120,shade = 0.75,ticktype = "detailed",xlab = "X", ylab = "Y", zlab = "Sinc(r)",main = "Cairo")
par(op)
dev.off()


library(MASS)
data(HairEyeColor)

x <- HairEyeColor[,,1]+HairEyeColor[,,2]
n <- 100
m <- matrix(sample(c(T,F),n^2,replace=T), nr=n, nc=n)

png(file="plot5.png",width=640,height=480)
biplot(corresp(m, nf=2), main="Plot")
dev.off()

CairoPNG(file="Cairo5.png",width=640,height=480)
biplot(corresp(m, nf=2), main="Cairo")
dev.off()

svg(file="plot-svg5.svg",width=6,height=6)
biplot(corresp(m, nf=2), main="Plot-svg")
dev.off()

CairoSVG(file="Cairo-svg5.svg",width=6,height=6)
biplot(corresp(m, nf=2), main="Cairo-svg")
dev.off()
