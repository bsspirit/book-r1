install.packages("formatR")
library(formatR)

tidy.source(text = c("{if(TRUE)1 else 2; if(FALSE){1+1", "## comments", "} else 2}"))

messy = system.file("format", "messy.R", package = "formatR")
messy
src = readLines(messy)
cat(src,sep="\n")
tidy.source(messy)

x = "demo.r"
tidy.source(x)

f="demo2.r"
tidy.source(x, keep.blank.line = TRUE, file = f)
file.show(f)

tidy.eval(text = c("a<-1+1;a", "matrix(rnorm(10),5)"))

var
usage(var)
usage(lm)
usage(lm,width=30)

install.packages("gWidgetsRGtk2")
library("gWidgetsRGtk2")
g = tidy.gui()

tidy.dir(path="dir")

# R 3.0.1，BUG测试
c('11',832)->x2
x2
tidy.source(text="c('11',832)->x2")
tidy.eval(text="c('11',832)->x2")
sessionInfo()

