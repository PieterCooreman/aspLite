<%
dim form : set form=aspl.form

'form-submitted
if form.postback then

	form.doScroll=true
	
	'here you would typically perform additional validations, return error messages, and finally save to a database (or delete)
	'below I add a feedback message as a comment to the form
		
	'feedback
	dim feedback : set feedback=form.field("element")
	
	select case aspl.getRequest("aspFormAction")
	
		case "save"
		
			feedback.add "html","Successfully saved!"			
			feedback.add "tag","div"
			feedback.add "class","alert alert-primary"			
		
		case "delete"
	
			feedback.add "html","Record Deleted!"			
			feedback.add "tag","div"
			feedback.add "class","alert alert-warning"
			
			'in case of a delete, we may want to no longer show anything but this feedback message
			form.build()
	
	end select
	
	'rather than return the complete form in case of a successful submit, 
	'you can also build it here already. This will stop further exection
	'form.build()

end if	

'##########################################################################################

dim aspFormAction : set aspFormAction=form.field("hidden")
aspFormAction.add "name","aspFormAction"
aspFormAction.add "id","aspFormAction"

'##########################################################################################
dim reasons: set reasons=aspl.dict
reasons.add 0,"I don't like ASP.NET"
reasons.add 1,"I simply prefer ASP"
reasons.add 2,"Don't know"

dim yesno : set yesno=form.field("select")
yesno.add "label","Why are you still developing in ASP/VBScript? (multiple selections)"
yesno.add "multiple",true
yesno.add "size",3
yesno.add "id","yesno"
yesno.add "name","yesno"
yesno.add "class","form-control"
yesno.add "options",reasons 'VBSscript dictionary!

'##########################################################################################

dim activities : set activities=aspl.dict
activities.add 0,"web design"
activities.add 1,"web hosting"
activities.add 2,"web development"

dim checkbox : set checkbox=form.field("checkbox")
checkbox.add "label","I am active in"
checkbox.add "name","checkbox"
checkbox.add "options",activities 'VBSscript dictionary!

'##########################################################################################

dim radios : set radios=aspl.dict
radios.add 0,"Beginner"
radios.add 1,"Intermediate"
radios.add 2,"Advanced"

dim radio : set radio=form.field("radio")
radio.add "label","How would you rate yourself as a developer?"
radio.add "id","radio"
radio.add "name","radio"
radio.add "options",radios 'VBSscript dictionary!

'##########################################################################################

dim submit : set submit=form.field("submit")
submit.add "name","btnSave"
submit.add "value","Submit"
submit.add "style","margin-top:15px"
submit.add "class","btn btn-primary"
submit.add "container","span"
submit.add "onclick","$('#aspFormAction').val('save')"

dim reset : set reset=form.field("reset")
reset.add "html","Reset"
reset.add "style","margin-left:10px;margin-top:15px"
reset.add "class","btn btn-warning"

'##########################################################################################

form.build()

%>