<!-- Copyright (c) 2003, webMethods Inc.  All Rights Reserved. -->

<html>
	<head>
		<style type='text/css'>

			.field{width:140px;}
		</style>
		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<script src="/WmRoot/webMethods.js.txt"></script>
		<script>
			function onSubmit()
			{			
				
				var table = document.getElementById("VariablesTable");
				var variables = "<Variables>"
				
				for (var i = 1, row; row = table.rows[i]; i++) {
				   //iterate through rows
				   //rows would be accessed using the "row" variable assigned in the for loop
				   var col1= row.cells[0].innerText;
				   var col2= row.cells[1].innerText;
				   
				   variables = variables + "<Variables><name>" + col1 + "</name><value>" + col2 + "</value></Variables>"				   				   
				}								
				variables = variables + "</Variables>"
				document.getElementById("VariablesXML").value = variables;
				
				document.config.submit();
				return true;
			}		
			function addVariable(){
				var table = document.getElementById("VariablesTable");
				var variableName = document.getElementById("VariableName").value;
				var variableValue = document.getElementById("VariableValue").value;
				document.getElementById("VariableName").value = "";
				document.getElementById("VariableValue").value = "";
				
				// Create an empty <tr> element and add it to the 1st position of the table:
				var row = table.insertRow(-1);

				// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				var cell3 = row.insertCell(2);
				
				cell1.innerHTML = variableName;				
				cell2.innerHTML = variableValue;
				cell3.innerHTML = "<input type='button' value='X' onclick='removeVariable()'/>";
				
			}
			function removeVariable(){				
				event.srcElement.parentElement.parentElement.remove();
			}
		</script>
	</head>
	<body onLoad="setNavigation('controllerAddTask.dsp');">
		<table width="100%">
			%ifvar action equals('addTask')%
				%invoke wmKryonRPA.dsp:addTask%									
				%ifvar AddTaskResponse/Status equals('0')%
					<script>writeMessage("TaskId:%value AddTaskResponse/TaskId% , Status:%value AddTaskResponse/Status%,%value AddTaskResponse/Error%");</script>
				%else%
					<script>writeMessage("Status:%value AddTaskResponse/Status%,Error: %value AddTaskResponse/Error%");</script>
				%end if%
				%onerror%
					%loop -struct%
						<tr><td>%value $key%=%value%</td></tr>
					%endloop%
				%endinvoke%
			%end if%
		</table>
				
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
				  WmKryonRPA &gt; Add Task 
				</td>
			</tr>
			<tr>
				<td>
					<form name="config">						
						<table class="tableForm" border="1">
							<tr>
								<td class="heading" colspan="2">Add Task Parameters</td>
							</tr>
							<tr>	
								<td>Wizard custom id</td>
									<script> writeTD("rowdata-l");</script>											
									<input type="text" class="field" name="WizardCustomId" value="custom name"/></td>								
							</tr>
							<tr>
								<td>Number of runs</td>
									<script> writeTD("rowdata-l");</script>
								<input type="text" class="field" name="NumberOfRuns" value="1"/></td>														
							</tr>
							<tr>
								<td>Single run estimation</td>
									<script> writeTD("rowdata-l");</script>
								<input type="text" class="field" name="SingleRunEstimation" value="10"/></td>
							</tr>
							<tr>
								<td>Queue priority</td>
									<script> writeTD("rowdata-l");</script>
									<select class="field" name="QueuePriority" style="width:140px">
										<option value="0">Normal</option>
										<option value="1">High</option>
									</select></td>
									
							</tr>
							<tr>
								<td>Group Name</td>
									<script> writeTD("rowdata-l");</script>
								<input type="text" class="field" name="GroupName" value=""/></td>
							</tr>
							<tr>
								<td>Machine Name</td>
									<script> writeTD("rowdata-l");</script>
								<input type="text" class="field" name="MachineName" value=""/></td>
							</tr>		
							<tr>
								<td colspan="2">Variables</td>
								
							</tr>
							<tr>
								<td colspan="2">
									<table id="VariablesTable" border="1">
										<tr>
											<td><input type="text" id="VariableName" name="VariableName" value=""/></td>
											<td><input type="text" id="VariableValue" name="VariableValue" value=""/></td>
											<td><input type="button" value="Add" onclick="addVariable();"/></td>
										</tr>
									</table> 
								</td>
							</tr>
							<tr>
								<td class="action" colspan=2>
									<input type="hidden" name="action" value="addTask">
									<input type="hidden" name="edit">									
									<input type="button" value="Submit" onclick="onSubmit();">
									<input type="hidden" id="VariablesXML" name="VariablesXML" value=""/>
								</td>
							</tr>
						</table>						
					</form>
				</td>
			</tr>
		</table>
	</body>
</html>
