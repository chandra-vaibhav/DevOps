<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" CONTENT="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js">
  </script>
</head>

<body onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JNDIaliasDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JNDI Settings &gt; JNDI Provider Alias</td>
    </tr>

    %ifvar action equals('edit')%
    
      %invoke wm.server.jndi:setJNDIAliasData%    
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</td>
        </tr>
      %onerror%
        <tr>
          <td class="message" colspan=2>%value errorMessage encode(html)%</td>
        </tr>
      %endinvoke%
    %endif%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jndi", "settings-jndi.dsp", "POST", "BODY");
		  createForm("htmlform_settings_jndi_edit", "settings-jndi-edit.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_jndi_edit", "jndiAliasName", "%value jndiAliasName%");
		  </script>
          <li class="listitem"><script>getURL("settings-jndi.dsp", "javascript:document.htmlform_settings_jndi.submit();", "Return to JNDI Settings");</script>
		  </li>
          <li class="listitem"><script>getURL("settings-jndi-edit.dsp?jndiAliasName=%value jndiAliasName encode(url)%", "javascript:document.htmlform_settings_jndi_edit.submit();", "Edit JNDI Provider Alias");</script>
		  </li>
        </ul>
      </td>
    </tr>

    <tr>
      <td>
        <table class="tableView" width="85%">
        
        %invoke wm.server.jndi:getJNDIAliasData%

          <tr>
            <td class="heading" colspan=2>JNDI Provider Alias</td>
          </tr>
          <tr>
            <td class="oddrow-l" scope="row">JNDI Alias Name</td>
            <td class="oddrowdata-l">%value aliasName encode(html)%</td>
          </tr>
          <tr>
            <td class="evenrow-l" scope="row">Description</td>
            <td class="evenrowdata-l">%value description encode(html)%</td>
          </tr>
          <tr>
            <td class="oddrow-l" nowrap scope="row">Initial Context Factory</td>
            <td class="oddrowdata-l">%value initialContextFactory encode(html)%</td>
          </tr> 
          <tr>
            <td class="evenrow-l" scope="row">Provider URL</td>
            <td class="evenrowdata-l">%value providerURL encode(html)%</td>
          </tr> 
          <tr>
            <td class="oddrow-l" scope="row">Provider URL Failover List</td>
            <td class="oddrowdata-l">
              <textarea name="otherProps" cols=70 rows=3 readonly class="evenrow-l" wrap=off>%value providerURLFailoverList encode(html)%</textarea>
            </td>
          </tr>  
          <tr>
            <td class="evenrow-l" scope="row">Security Principal</td>
            <td class="evenrowdata-l">%value securityPrincipal encode(html)%</td>
          </tr>
            <tr>
            <td class="oddrow-l" scope="row">Security Credentials</td>
            <td class="oddrowdata-l">%ifvar securityCredentials -notempty%******%endif%</td>
          </tr> 
          <tr>
            <td class="evenrow-l" scope="row">Other Properties</td>
            <td class="evenrowdata-l">
              <textarea name="otherProps" cols=70 rows=3 readonly class="evenrow-l" wrap=off>%value otherProps encode(html)%</textarea>
            </td>
          </tr> 
            
        %onerror%
          <tr>
            <td class="message" colspan=2>%value errorMessage encode(html)%<br>%value error encode(html)% at %value errorService encode(html)%<br></td>
          </tr>
        %endinvoke%
          
        </table>   
      </td>
    </tr>
    
  </table>
</body>
</html>
