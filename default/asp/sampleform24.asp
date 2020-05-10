<%
dim form : set form=aspl.form
form.initialize=false

'we can create some fields only once

'hidden field indicating the next question
set nextquestion = form.field("hidden")
nextquestion.add "name","nextquestion"

'the question
set question = form.field("element")
question.add "tag","div"
question.add "class","alert alert-info"

'the radio buttons (assuming all questions will be radio buttons)
set answer = form.field("radio")	

'the next button
set submit = form.field("submit")
submit.add "class","btn btn-info btn-sm"
submit.add "style","margin-top:10px"

'keep track of the answers in session object
'this could also be done by adding hidden fields for each answer
if not aspl.isEmpty(aspl.getRequest("answer1")) then
	session("answer1")=aspl.getRequest("answer1")
end if

if not aspl.isEmpty(aspl.getRequest("answer2")) then
	session("answer2")=aspl.getRequest("answer2")
end if

if not aspl.isEmpty(aspl.getRequest("answer3")) then
	session("answer3")=aspl.getRequest("answer3")
end if

select case aspl.convertNmbr(aspl.getRequest("nextquestion"))

	case 0 'start	
		
		nextquestion.add "value","1"		
		
		question.add "html","This quiz has 3 difficult questions!"	
		
		answer.add "style","display:none"
		
		submit.add "value","Start the Quiz!"			

	case 1	
		
		nextquestion.add "value","2"

		question.add "html","Is ASP dead?"				

		set options=aspl.dict
		options.add 0,"Yes"
		options.add 1,"No"	
			
		answer.add "options",options
		answer.add "name","answer1"
		answer.add "required",true		
		
		submit.add "value","Proceed to Q2"		

	case 2		
		
		nextquestion.add "value","3"	
		
		question.add "html","How many ASP-versions are there?"
		
		set options=aspl.dict
		options.add 1,"one"
		options.add 2,"two"
		options.add 3,"three"		
		
		answer.add "options",options
		answer.add "name","answer2"
		answer.add "required",true
		
		submit.add "value","Proceed to Q3"		

	case 3		
		
		nextquestion.add "value","4"

		question.add "html","Is aspLite the future or the past?"		
		
		set options=aspl.dict
		options.add 0,"the future"
		options.add 1,"the past"		
		
		answer.add "label",""	
		answer.add "options",options
		answer.add "name","answer3"
		answer.add "required",true
		
		submit.add "value","See your score!"		

	case 4	

		nextquestion.add "value","1"		
		
		set correctanswers = aspl.dict
		correctanswers.add 1,"1" 'classic ASP is not dead
		correctanswers.add 2,"3" 'three
		correctanswers.add 3,"0" 'the future!
		
		userscore=0
		
		if correctanswers(1)=session("answer1") then userscore=userscore+1
		if correctanswers(2)=session("answer2") then userscore=userscore+1
		if correctanswers(3)=session("answer3") then userscore=userscore+1
			
		question.add "html","Your score: <strong>" & userscore & "/3</strong>"

		answer.add "style","display:none"		
		
		submit.add "value","Start again"	

end select	

form.build()

%>