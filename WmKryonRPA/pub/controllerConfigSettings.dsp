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
				
				var element = document.config.Password;
				// Don't submit passwords if they have not been changed.
				if (element.value == "********")
				{
					element.disabled = true;
				}
				
				document.config.edit.value = true;
				document.config.submit();
				return true;
			}													
		</script>
	</head>
	<body onLoad="setNavigation('controllerConfigSettings.dsp');">
		<table width="100%">
			%ifvar action equals('saveConfiguration')%
				%invoke wmKryonRPA.dsp:setConfiguration%					
				%switch status%
					%case 'Success'%
						<script>writeMessage("%value status%");</script>
					%case 'warning'%
						<script>writeMessage("%value status%");</script>
					%case 'error'%
						<script>writeMessage("%value status%");</script>
				%end%
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
				  WmKryonRPA &gt; Configuration Settings 
				</td>
			</tr>
			<tr>
				<td>
					<form name="config">
						%invoke wmKryonRPA.dsp:getConfiguration%	
						<table class="tableForm">
							<tr>
								<td class="heading" colspan="2">Configuration Settings</td>
							</tr>
							<tr>	
								<td>Kryon WebAPI URL</td>
									<script> writeTD("rowdata-l");</script>											
									<input type="text" name="KryonWebAPIURL" value="%value Configuration/KryonWebAPIURL%"/>
								</td>
							</tr>
							<tr>
								<td>User Name</td>
									<script> writeTD("row");</script>
								<input type="text" name="UserName" value="%value Configuration/UserName%"/></td>
								</td>								
							</tr>
							<tr>
								<td>Password</td>
									<script> writeTD("row");</script>
								<input type="text" name="Password" value="********"/></td>
								</td>								
							</tr>
							<tr>
								<td class="action" colspan=2>
									<input type="hidden" name="action" value="saveConfiguration">
									<input type="hidden" name="edit">									
									<input type="button" value="Submit" onclick="onSubmit();">
								</td>
							</tr>
						</table>
						%endinvoke%
					</form>
				</td>
			</tr>
		</table>
	</body>
</html>
