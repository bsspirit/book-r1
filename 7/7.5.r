library(rhbase)
hb.init()
hb.new.table("student_rhbase","info",opts=list(maxversions=5,x=list(maxversions=1L,compression='GZ',inmemory=TRUE)))
hb.list.tables()
hb.describe.table("student_rhbase")
hb.insert("student_rhbase",list(list("mary","info:age", "24")))
hb.get('student_rhbase','mary')
hb.delete.table('student_rhbase')










