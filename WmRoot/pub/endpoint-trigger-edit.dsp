<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="Expires" content="-1">
  <title>Integration Server Settings</title>
  <link rel="stylesheet" type="text/css" href="webMethods.css">
  <script src="webMethods.js"></script>

  
  <script Language="JavaScript">
      
      var oldMaxExecutionThreads = "1";
      var oldConnectionCount = "1";
      var procModeIsSerial = false;
      
      %invoke wm.server.jms:getTriggerReport%
      var maxThreadsAsString = "%value trigger/maxThreadsString encode(javascript)%";
      var maxThreads = maxThreadsAsString.substring(maxThreadsAsString.indexOf('(')+1, maxThreadsAsString.indexOf(')'));
      
      function init()
      {
            %loop trigger/destinations%
			    document.editform.destinationName.value = "%value destination encode(javascript)%";
            %endloop%

            %ifvar trigger/concurrent equals('true')%
                document.editform.concurrent[0].checked = true;
            %else%
                document.editform.concurrent[1].checked = true;
                document.editform.maxExecutionThreads.disabled=true;
                document.editform.connectionCount.disabled=true;
                procModeIsSerial=true;
            %endif%
        
            document.editform.maxExecutionThreads.value = maxThreads;
        
        /*
            if ( document.editform.concurrent[0].checked == true) 
            {
                document.editform.maxExecutionThreads.value = maxThreads;
                document.editform.maxExecutionThreads.disabled = false;
            }
              else
            {
                document.editform.maxExecutionThreads.value = "N/A";
                document.editform.maxExecutionThreads.disabled = true;
            }
            */  
      }
     
    function modeChange()
    {
          if ( document.editform.concurrent[0].checked == true) 
          {
              document.editform.maxExecutionThreads.value = maxThreads;
              document.editform.maxExecutionThreads.disabled = false;
          }
          else
          {
              document.editform.maxExecutionThreads.value = "N/A";
              document.editform.maxExecutionThreads.disabled = true;
          }
    }
    
    function changeToSerial(f) {
      if (!procModeIsSerial) {
        procModeIsSerial=true;
        oldMaxExecutionThreads = f.maxExecutionThreads.value;
        oldConnectionCount = f.connectionCount.value;
        f.maxExecutionThreads.disabled=true;
        f.maxExecutionThreads.value="1";
        f.connectionCount.disabled=true;
        f.connectionCount.value="1";
      }
    }
    
    function changeToConcurrent(f) {
      procModeIsSerial=false;
      f.maxExecutionThreads.disabled=false;
      f.maxExecutionThreads.value=oldMaxExecutionThreads;
      f.connectionCount.disabled=false;
      f.connectionCount.value=oldConnectionCount;
    }
    
  </script>
  
  
</head>

<body onLoad="init(); setNavigation('endpoint-trigger-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmt_Edit_WSEndpontTrigger');">

<table width="100%">
  <tbody>
    <tr>
      <td class="breadcrumb" colspan="4">Settings &gt; Messaging &gt; JMS Trigger Management &gt; Edit Trigger &gt; WS Endpoint Trigger: %value trigger/wseAlias encode(html)%<br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
      <ul class="listitems">
        
		  <li>
			
			<script>
			 createForm("htmlForm_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
			setFormProperty("htmlForm_settings_jms_trigger_management", "type", "soap");
           </script>
		   <script>getURL("settings-jms-trigger-management.dsp?type=soap", "javascript:document.htmlForm_settings_jms_trigger_management.submit();", "Return to JMS Trigger Management");</script>
		
		</li>
        <li>
		<script>
			 createForm("htmlForm_endpoint_trigger_details", "endpoint-trigger-details.dsp", "POST", "BODY");
			setFormProperty("htmlForm_endpoint_trigger_details", "triggerName", "%value triggerName encode(javascript)%");
        </script>
		<script>getURL("endpoint-trigger-details.dsp?triggerName=%value triggerName encode(url)%", "javascript:document.htmlForm_endpoint_trigger_details.submit();", "Return to Trigger Detail");</script>
		
		</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td>
        <table class="tableView" width="40%">
        <tbody>
          <form name="editform" action="endpoint-trigger-details.dsp?triggerName=%value triggerName encode(url)%" METHOD="POST">
        
            <tr>
              <td class="heading" colspan="2">Properties</td>
            </tr>
  
            <tr>
              <td class="oddrow-l"><label for="aliasName">JMS Connection Alias</label></td>
              <td class="oddrowdata-l">
                    %invoke wm.server.jms:getConnectionAliasReport%
			          <SELECT name="aliasName" id="aliasName" >
                        %loop aliasDataList%
					        <OPTION value="%value aliasName encode(htmlattr)%" %ifvar aliasName vequals(../trigger/aliasName)% selected %endif%>%value aliasName encode(html)%</OPTION>
                        %endloop%
                      </SELECT>
                    %endinvoke%
              </td>   
            </tr>
            
            <tr>
              <td class="evenrow-l"><label for="destinationName">Destination Name</label></td>
              <td class="evenrowdata-l">
		            <input type="text" name="destinationName" id="destinationName" >
	            </td>
            </tr>
        
              <tr>
              <td class="oddrow-l">Processing Mode</td>
              <td class="oddrowdata-l">
	             <input type="radio" name="concurrent" id="concurrent"  value="true" onclick="changeToConcurrent(this.form);"><label for="concurrent">Concurrent</label></input>
		         <input type="radio" name="concurrent" id="serial"  value="false" onclick="changeToSerial(this.form);"><label for="serial">Serial</label></input>
              </td>
            </tr>

            <tr>
                <td class="evenrow-l"><label for="maxExecutionThreads">Max Execution Threads</label></td>
                <td class="evenrowdata-l">
                  <input type="text" name="maxExecutionThreads" id="maxExecutionThreads" >
                </td>
             </tr>
   
             <tr>
                <td class="oddrow-l"><label for="connectionCount">Connection Count</label></td>
                <td class="oddrowdata-l">
                  <input type="text" name="connectionCount" id="connectionCount"  value="%value trigger/connectionCount encode(htmlattr)%">
                </td>
             </tr>
          
            <tr>
              <td class="action" colspan=2>
                <input name="triggerName" type="hidden" value="%value triggerName encode(htmlattr)%">
		            <input name="enabled" type="hidden" value="%value trigger/enabled encode(htmlattr)%">
                <input name="action" type="hidden" value="update">
                <input type="submit" value="Save Changes">
              </td>
            </tr>
           </form>
         </tbody>
         </table>
      </td>
    </tr>
  </tbody>
</table>

 %endinvoke%
</body>
</html>
