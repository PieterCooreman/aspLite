<%
Class cls_asp_accessDB

	public path

	private p_getConn
	
	Private Sub Class_Initialize()
		set p_getConn = nothing
	End Sub
	
	Private Sub Class_Terminate()
		set p_getConn = nothing
	End Sub
	
	Public Function Execute(sql)
	
		On Error Resume Next	
		
		dim connection
		set connection = getConn()
		Set Execute = connection.Execute(sql)
		
		if err.number<>0 then			
			asp.asperror "The query """ & server.htmlEncode(sql) & """ cannot be executed. There may be a connection error and/or a mistake in the SQL-syntax."
		end if
		
		On Error Goto 0
		
	End Function
	

	Public Function GetDynamicRS
	
		On Error Resume Next
		
		Set GetDynamicRS = server.CreateObject ("adodb.recordset")
		GetDynamicRS.CursorType = 1
		GetDynamicRS.LockType = 3
		set GetDynamicRS.ActiveConnection = getConn()
		
		On Error Goto 0
		
	End Function
	
	Private function getConn()
	
		On Error Resume Next
		
		if p_getConn is nothing then
			Set p_getConn = Server.Createobject("ADODB.Connection")		
			p_getConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.mappath(path)	
			
		end if			
		
		if err.number<>0 then	
		
			dim errM
			errM="Something went wrong while connection to the database:<ul>"
			errM=errM &"<li>You may need to enable 32 Bits application for your IIS application pool.</li>"
			errM=errM &"<li>The path to your database is not correct</li>"
			errM=errM &"<li>IUSR has not sufficient permissions on the database file/folder</li>"
			errM=errM &"</ul><p>To be sure, check the error message below:</p>"
			
			asp.asperror (errM)			
			
		end if

		set getConn=p_getConn

		On Error Goto 0
		
	end function
	
End Class%>
