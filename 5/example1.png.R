run <- function(...) {
  p <- WebPlot(600, 600)
  plot(rnorm(100), rnorm(100), pch = 19, col = 2)
  p
}
