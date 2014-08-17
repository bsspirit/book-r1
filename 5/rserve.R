## 增加的内容
library(FastRWeb)
.http.request <- FastRWeb:::.http.request

## 以下为原来文件的内容
## Today, pretty much everyone speaks UTF-8, it makes the life easier
Sys.setlocale(,"en_US.UTF-8")

## it is useful to have access to the root of your
## installation from R scripts
root <- Sys.getenv("ROOT")
if (is.null(root) || nchar(root) == 0) root <- "/var/FastRWeb"

## run the server in the "tmp" directory of the root in
## case some files need to be created
setwd(paste(root,"tmp",sep='/'))

## if you have multiple servers it's good to know which machine this is
host <- tolower(system("hostname -s", TRUE))
cat("Starting Rserve on", host,"\n")

## This is jsut a friendly way to load package and report success/failure
## You will definiteily need FastRWeb, others are optional
pkgs <- c("XML", "Cairo", "Matrix", "FastRWeb")
cat("Loading packages...\n")
for (pkg in pkgs) cat(pkg, ": ",require(pkg, quietly=TRUE, character.only=TRUE),"\n",sep='')

## fix font mappings in Cairo -- some machines require this
if (exists("CairoFonts")) CairoFonts("Arial:style=Regular","Arial:style=Bold","Arial:style=Italic","Helvetica","Symbol")

## Load any data you want
data.fn <- paste(root, "code", "data.RData", sep='/')
if (isTRUE(file.exists(data.fn))) {
  cat("Loading data...\n")
  load(data.fn)
}

## init() is a special function that will be called from
## each script. Do what you want here - it is usually a good idea
## to have a "common" script that is loaded on each request
## so you don't need re-start Rserve for global code changes
init <- function() {
    set.seed(Sys.getpid()) # we want different seeds so we get different file names

    ## get a temporary file name for this session
    tmpfile<<-paste('tmp-',paste(sprintf('%x',as.integer(runif(4)*65536)),collapse=''),'.tmp',sep='')

    ## if there is a common script, source it first
    common <- paste(root,"/web.R/common.R",sep='')
    if (isTRUE(file.exists(common))) source(paste(root,"/web.R/common.R",sep=''))
}
