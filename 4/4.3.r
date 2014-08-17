install.packages("rJava")
library(rJava)

search()
.jinit()
.jcall(s,"I","length")
.jcall(s,"I","indexOf","World")
.jmethods(s,"concat")
.jcall(s,"Ljava/lang/String;","concat",s)
print(s)
.jstrVal(s)

s$length()
s$indexOf("World")








