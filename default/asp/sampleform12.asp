<%
dim rss : set rss=aspL.plugin("rss")
rss.maxitems=1

dim form : set form=aspl.form
	
'result
dim feedback : set feedback=form.field("element")
feedback.add "html",rss.read("http://rss.cnn.com/rss/cnn_topstories.rss")
feedback.add "tag","div"

form.build()

%>