<%
dim rs,field,datatable	
set rs=db.rs : rs.open ("select * from person")

datatable="<tr>"

'get headers
for each field in rs.fields	
	datatable=datatable & "<th scope=""col"">" & aspL.sanitize(field.name) & "</th>"		
next

datatable=datatable & "</tr>"

while not rs.eof	

	datatable=datatable & "<tr>"

	for each field in rs.fields	
		datatable=datatable & "<td>" & aspL.sanitize(rs(field.name)) & "</td>"
	next
	
	datatable=datatable & "</tr>"
	
	rs.movenext

wend

set rs=nothing

'formbuilder sample - built on bootstrap css
aspl.exec("code/demo_asp/formbuilder/formbuilder.asp")

dim form : set form=new cls_formbuilder
form.listenTo "e","sampleform8"
form.targetDiv="sampleform8"
form.id="datatable"
	
'result
dim feedback : set feedback=form.field
feedback.add "type","comment"
feedback.add "html","<table class=""table table-striped""><tbody>" & datatable & "</tbody></table>"
feedback.add "tag","div"

form.build()

%>