install.packages("xts")
library(xts)

data(sample_matrix)
head(sample_matrix)

sample.xts <- as.xts(sample_matrix, descr='my new xts object')
class(sample.xts)
str(sample.xts)
attr(sample.xts,'descr')

head(sample.xts['2007'])
head(sample.xts['2007-03/'])
head(sample.xts['2007-03-06/2007'])
sample.xts['2007-01-03']

data(sample_matrix)
plot(as.xts(sample_matrix))
plot(as.xts(sample_matrix), type='candles')

firstof(2000)
firstof(2005,01,01)
lastof(2007)
lastof(2007,10)

.parseISO8601('2000')
.parseISO8601('2000-05/2001-02')
.parseISO8601('2000-01/02')
.parseISO8601('T08:30/T15:00')

x <- timeBasedSeq('2010-01-01/2010-01-02 12:00')
head(x)
class(x)
x <- xts(1:length(x), x)
head(x)
indexClass(x)

indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3"
head(x)
.indexhour(head(x))
.indexmin(head(x))

x <- Sys.time() + 1:30
align.time(x, 10)
align.time(x, 60)

xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
apply.monthly(xts.ts,mean)
apply.monthly(xts.ts,function(x) var(x))
apply.quarterly(xts.ts,mean)
apply.yearly(xts.ts,mean)

data(sample_matrix)
to.period(sample_matrix)
class(to.period(sample_matrix))
samplexts <- as.xts(sample_matrix)
to.period(samplexts)
class(to.period(samplexts))


data(sample_matrix)
endpoints(sample_matrix)
endpoints(sample_matrix, 'days',k=7)
endpoints(sample_matrix, 'weeks')
endpoints(sample_matrix, 'months')

(x <- xts(4:10, Sys.Date()+4:10))
(y <- xts(1:6, Sys.Date()+1:6))
merge(x,y)
merge(x,y, join='inner')
merge(x,y, join='left')

x <- xts(1:3, Sys.Date()+1:3)
rbind(x,x)

data(sample_matrix)
x <- as.xts(sample_matrix)
split(x)[[1]]
split(x, f="weeks")[[1]]
split(x, f="weeks")[[2]]

x <- xts(1:10, Sys.Date()+1:10)
x[c(1,2,5,9,10)] <- NA
x
na.locf(x)
na.locf(x, fromLast=TRUE)

xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))

start(xts.ts)
end(xts.ts)
periodicity(xts.ts)


data(sample_matrix)
ndays(sample_matrix)
nweeks(sample_matrix)
nmonths(sample_matrix)
nquarters(sample_matrix)
nyears(sample_matrix)

zoo.data <- zoo(rnorm(31)+10,as.Date(13514:13744,origin="1970-01-01"))
ep <- endpoints(zoo.data,'weeks');ep
period.apply(zoo.data, INDEX=ep, FUN=function(x) mean(x))
head(period.max(zoo.data, INDEX=ep))
head(period.min(zoo.data, INDEX=ep))
head(period.prod(zoo.data, INDEX=ep))

class(Sys.time());timeBased(Sys.time())
class(Sys.Date());timeBased(Sys.Date())
class(20070101);timeBased(20070101)

timeBasedSeq('1999/2008')
head(timeBasedSeq('199901/2008'))
head(timeBasedSeq('199901/2008/d'),40)
timeBasedSeq('20080101 0830',length=100)

x <- xts(1:100, Sys.Date()+1:100)
head(x)
first(x, 10)
first(x, '1 day')
last(x, '1 weeks')

x <- xts(1:5, Sys.Date()+1:5)
lag(x)
lag(x, k=-1, na.pad=FALSE)
diff(x)
diff(x, lag=2)

isOrdered(1:10, increasing=TRUE)
isOrdered(1:10, increasing=FALSE)
isOrdered(c(1,1:10), increasing=TRUE)
isOrdered(c(1,1:10), increasing=TRUE, strictly=FALSE)

x <- xts(1:5, as.POSIXct("2011-01-21") + c(1,1,1,2,3)/1e3)
x
make.index.unique(x)

x <- xts(1:10, Sys.Date()+1:10)
indexTZ(x)
tzone(x)
str(x)












