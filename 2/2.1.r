install.packages("zoo")
library(zoo)

x.Date <- as.Date("2003-02-01") + c(1, 3, 7, 9, 14) - 1
x.Date
class(x.Date)

x <- zoo(rnorm(5), x.Date)
x
class(x)
plot(x)

y <- zoo(matrix(1:12, 4, 3),0:10)
y
plot(y)

zooreg(1:10, frequency = 4, start = c(1959, 2))
as.zoo(ts(1:10, frequency = 4, start = c(1959, 2)))
zr<-zooreg(rnorm(10), frequency = 4, start = c(1959, 2))
plot(zr)

x <- c(1, 2, 3, 6, 7, 8)
zz <- zoo(x, x)
zr <- as.zooreg(zz)

lag(zz, k = -1)
lag(zr, k = -1)
diff(zz)
diff(zr)

as.zoo(rnorm(5))
as.zoo(ts(rnorm(5), start = 1981, freq = 12))
x <- as.zoo(ts(rnorm(5), start = 1981, freq = 12))
x

as.matrix(x)
as.vector(x)
as.data.frame(x)
as.list(x)   

library(ggplot2)
library(scales)
x.Date <- as.Date(paste(2003, 02, c(1, 3, 7, 9, 14), sep = "-"))
x <- zoo(rnorm(5), x.Date)
xlow <- x - runif(5)
xhigh <- x + runif(5)
z <- cbind(x, xlow, xhigh)
z
g<-ggplot(aes(x = Index, y = Value), data = fortify(x, melt = TRUE))
g<-g+geom_line()
g<-g+geom_line(aes(x = Index, y = xlow), colour = "red", data = fortify(xlow))
g<-g+geom_ribbon(aes(x = Index, y = x, ymin = xlow, ymax = xhigh), data = fortify(x), fill = "darkgray")
g<-g+geom_line()
g<-g+xlab("Index") + ylab("x")
g

x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
coredata(x)
coredata(x) <- matrix(1:20, ncol = 2)
x

x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
index(x)
index(x) <- 1:nrow(x)
index(x)

x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(matrix(rnorm(20), ncol = 2), x.date)
window(x, start = as.Date("2003-02-01"), end = as.Date("2003-03-01"))
window(x, index = x.date[1:6], start = as.Date("2003-02-01"))
window(x, index = x.date[c(4, 8, 10)])

y1 <- zoo(matrix(1:10, ncol = 2), 1:5);y1
y2 <- zoo(matrix(rnorm(10), ncol = 2), 3:7);y2
merge(y1, y2, all = FALSE)
merge(y1, y2, all = FALSE, suffixes = c("a", "b"))
merge(y1, y2, all = TRUE)
merge(y1, y2, all = TRUE, fill = 0)

x.date <- as.Date(paste(2004, rep(1:4, 4:1), seq(1,20,2), sep = "-"))
x <- zoo(rnorm(12), x.date); x
x.date2 <- as.Date(paste(2004, rep(1:4, 4:1), 1, sep = "-")); x.date2
x2 <- aggregate(x, x.date2, mean); x2

z <- zoo(11:15, as.Date(31:35))
rollapply(z, 2, mean)
rollapply(z, 3, mean)
z2 <- zoo(rnorm(6))
rollapply(z2, 3, mean, by = 3)
aggregate(z2, c(3,3,3,6,6,6), mean)
rollapply(z2, 3, mean)
rollmean(z2, 3)

z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA))
z
na.fill(z, "extend")
na.fill(z, -(1:3))
na.fill(z, c("extend", NA))
z <- zoo(c(NA, 2, NA, 3, 4, 5, 9, NA, 11));z
na.locf(z, fromLast = TRUE)

z <- zoo(c(1, NA, 3:9),c(as.Date("2010-01-01") + 0:2,as.Date("2010-02-01") + 0:2,as.Date("2011-01-01") + 0:2))
z
na.aggregate(z)
na.aggregate(z, as.yearmon)
na.aggregate(z, months)
na.aggregate(z, format, "%Y")

z <- zoo(c(2, NA, 1, 4, 5, 2), c(1, 3, 4, 6, 7, 8));z
na.approx(z)
na.approx(z, 1:6)

z <- zooreg(rep(10 * seq(4), each = 4) + rep(c(3, 1, 2, 4), times = 4), start = as.yearqtr(2000), freq = 4)
z[10] <- NA
zout <- na.StructTS(z);zout
plot(cbind(z, zout), screen = 1, col = 1:2, type = c("l", "p"), pch = 20)

xx <- zoo(matrix(c(1, 4, 6, NA, NA, 7), 3), c(2, 4, 6));xx
na.trim(xx)


x <- as.yearqtr(2000 + seq(0, 7)/4);x
format(x, "%Y Quarter %q")
as.yearqtr("2001 Q2")
as.yearqtr("2001 q2")
as.yearqtr("2001-2")

x <- as.yearmon(2000 + seq(0, 23)/12);x
as.yearmon("mar07", "%b%y")
as.yearmon("2007-03-01")
as.yearmon("2007-12")

set.seed(0)
flow <- ts(filter(rlnorm(200, mean = 1), 0.8, method = "r"))
rgb <- hcl(c(0, 0, 260), c = c(100, 0, 100), l = c(50, 90, 50), alpha = 0.3)
plot(flow)
xblocks(flow 30, col = rgb[1]) ## high values red
xblocks(flow < 15, col = rgb[3]) ## low value blue
xblocks(flow >= 15 & flow <= 30, col = rgb[2]) ## the rest gray

r <- read.zoo(file="read.csv",sep = ",", format = "%Y-%m-%d")
r
class(r)













