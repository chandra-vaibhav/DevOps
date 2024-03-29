<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <SCRIPT SRC="webMethods.js"></SCRIPT>
  
  <script LANGUAGE="JavaScript">
    function valueAltered()
    {
        document.editform.isChanged.value = "true";
    }
    
    function confirmEdit ()
    {   
        if(isSpclChar(document.editform.name.value)){
            alert("The scope name contains illegal characters, provide a valid value.");
            document.editform.name.focus();
            return false;
        }
        document.editform.submit();
        return true;
    }   
    
  </script>
  
  %ifvar action equals('edit')%
    <body onLoad="setNavigation('security-oauth-scope-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthEditScopeScrn');">
  %else%
    <body onLoad="setNavigation('security-oauth-scope-addedit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OAuthAddScopeScrn');">
  %endif%
   
    <table width="100%">
    <tr>

      %ifvar action equals('edit')%
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; Scope Management &gt; %value name encode(html)% &gt; Edit</td>
      %else%
        <td class="breadcrumb" colspan="2"> Security &gt; OAuth &gt; Scope Management &gt; Add Scope</td>
      %endif%
    
    </tr>

      <tr>
        <td colspan="2">
          <ul class="listitems">
		    <script>
			createForm("htmlform_security_oauth_scope", "security-oauth-scope.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("security-oauth-scope.dsp","javascript:document.htmlform_security_oauth_scope.submit();","Return to Scope Management");</script></li>
          </ul>
        </td>
      </tr>     

    <TR>
        <TD>
        
        <FORM NAME="editform" ACTION="security-oauth-scope.dsp" METHOD="POST">
         <TABLE class="tableView" width="40%">
                <TR>
                    <TD class="heading" colspan=2>Scope Configuration</TD>
                </TR>
        
                <TR>
                    <TD class="oddrow" width="40%" nowrap>
						<label for="name1">Name</label>
                    </TD>
                    %ifvar action equals('edit')%
                        %invoke wm.server.oauth:getScope%           
                        %endinvoke%
                    %endif%

                    <TD class="oddrow-l">
						<input id="name" TYPE="hidden" NAME="isChanged" VALUE="false">
						%ifvar action equals('edit')%
							<input id="name1" NAME="name" VALUE="%value name encode(htmlattr)%" readonly="true" style="color:#808080;">
						%else%
							<input id="name1" NAME="name">
                        %endif%
                    </TD>
                </TR>
				
			    <TR>
				
                    <TD class="evenrow" nowrap><label for="description">Description</label></TD>
                    <TD class="evenrow-l">
                       %ifvar action equals('edit')%
            			 		<INPUT NAME="description" id="description" TYPE="TEXT" VALUE="%value description encode(htmlattr)%" SIZE="42" onChange="valueAltered()">
                       %else%
                                <INPUT NAME="description" id="description" TYPE="TEXT" VALUE="" SIZE="42" onChange="valueAltered()">
                       %endif%
                    </TD>
                </TR>
				
            <TR>
                <TD class="evenrow" nowrap><label for="redirectURI">Folders and services</label></TD>

                <TD class="oddrow-l">
                    %ifvar action equals('edit')%
          			 	 <textarea name="dsp_values" id="redirectURI" rows="5" cols="40" onChange="valueAltered()">%loop values%%value encode(html)% 
%endloop%</textarea> 
                    %else%
						<textarea NAME="dsp_values" id="redirectURI" rows="5" cols="40" onChange="valueAltered()"></textarea>
                    %endif%
                </TD>               
            </TR>
            
            <TR>
                <TD class="action" class="row"  colspan=2>
        	      <input TYPE="hidden" NAME="action" VALUE="%value action encode(htmlattr)%">
                  <input type="submit" name="submit" value="Save Changes" onclick="return confirmEdit()">
                </TD>
            </TR>
            </TABLE>
    
        </FORM>
        
    </TR>
      
      
     </table>
  </body>   
    
</head>
