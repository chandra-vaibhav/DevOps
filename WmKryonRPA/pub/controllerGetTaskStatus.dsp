<!-- Copyright (c) 2003, webMethods Inc.  All Rights Reserved. -->

<html>
	<head>
		<style type='text/css'>
			.readonlystyle { background: #ccc; }
		</style>
		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<script src="/WmRoot/webMethods.js.txt"></script>
		<script>
			function onSubmit()
			{															
				document.config.submit();
				return true;
			}													
		</script>
	</head>
	<body onLoad="setNavigation('controllerGetTaskStatus.dsp');">
		<table width="100%">
			%ifvar action equals('getTaskStatus')%
				%invoke wmKryonRPA.dsp:getTaskStatus%	
				
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
						<table class="tableForm">
							<tr>
								<td class="heading" colspan="2">Get Task Status Parameters</td>
							</tr>
							<tr>	
								<td>Task ID</td>
									<script> writeTD("rowdata-l");</script>											
									<input type="text" name="TaskId" value=""/>
								</td>
							</tr>
							
							%ifvar action equals('getTaskStatus')%
							<tr>
								<td colspan="2">								
									%ifvar TaskStatusResponse/Status equals('7')%
										<div style="width:100%;background-color:red;">TaskId: %value TaskStatusResponse/TaskId%, Task %value StatusDescription%, Error: %value ErrorDescription%</div>
									%else%
										<div style="width:100%;background-color:lightgreen;">TaskId: %value TaskStatusResponse/TaskId%, Task %value StatusDescription%</div>
									%end if%
								</td>								
							</tr>	
							%end if%				
							<tr>
								<td class="action" colspan=2>
									<input type="hidden" name="action" value="getTaskStatus">
									<input type="hidden" name="edit">									
									<input type="button" value="Submit" onclick="onSubmit();">
								</td>
							</tr>
						</table>						
					</form>
				</td>
			</tr>
		</table>
	</body>
</html>
