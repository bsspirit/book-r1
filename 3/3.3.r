library(devtools)
install_github("lineprof")
install_github("shiny-slickgrid", "wch")
library(lineprof)

source(find_ex("read-delim.r"))
wine <- find_ex("wine.csv")
df<-read.csv(file=wine)
object.size(df)
head(df)

x <- lineprof(read_delim(wine, sep = ","), torture = TRUE)
x

library(shinySlickgrid)
shine(x)











