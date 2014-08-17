install.packages("xtsExtra", repos="http://R-Forge.R-project.org")
library(xtsExtra)

names(formals(plot.xts))

> data(sample_matrix)
> sample_xts <- as.xts(sample_matrix)
> plot(sample_xts[,1])
> class(sample_xts[,1])

> plot(sample_xts[1:30, ], type = "candles")
> plot(sample_xts[1:30, ], type = "candles", bar.col.up = "blue", bar.col.dn = "violet", candle.col = "green4")
> plot(sample_xts[,1:2])
> plot(sample_xts[,rep(1:4, each = 3)])
> plot(sample_xts[,1:4], layout.screens = matrix(c(1,1,1,1,2,3,4,4),ncol = 2, byrow = TRUE))
> plot(sample_xts, screens = 1:2)
> plot(sample_xts, screens = c(1,2,1,2), col = c(1,3,2,2))
> plot(10^sample_xts, screens = 1:2, log= c("","y"))
> plot(sample_xts[1:75,1:2] - 50.5, type = c("l","h"), lwd = c(1,2))
> plot(sample_xts[,c(1:4, 3:4)], layout = matrix(c(1,1,1,1,2,2,3,4,5,6), ncol = 2, byrow = TRUE), yax.loc = "left")
> plot(sample_xts[,1], events = list(time = c("2007-03-15","2007-05-01"), label = "bad days"), blocks = list(start.time = c("2007-03-05", "2007-04-15"), end.time = c("2007-03-20","2007-05-30"), col = c("lightblue1", "lightgreen")))
> plot(sample_xts[,1],sample_xts[,2])

> cr <- colorRampPalette(c("#00FF00","#FF0000"))
> plot(sample_xts[,1],sample_xts[,2], xy.labels = FALSE, xy.lines = TRUE, col = cr(NROW(sample_xts)), type = "l")

> tser <- ts(cumsum(rnorm(50, 0.05, 0.15)), start = 2007, frequency = 12)
> class(tser)
> plot(tser)
> plot.xts(tser)

> x <- xts(matrix(abs(rnorm(72)), ncol = 6), Sys.Date() + 1:12)
> colnames(x) <- LETTERS[1:6]
> barplot(x)







