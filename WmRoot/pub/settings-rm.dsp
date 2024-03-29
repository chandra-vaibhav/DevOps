<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js"></script>
  <script language="JavaScript">
    function populateForm(form , seqID ,oper)
    {
        if('close' == oper)
            if (!confirm ("OK to close '"+seqID+"'?")) {
                return false;
            }
            form.operation.value = 'rm_close';  
        if('terminate' == oper)
        {
            if (!confirm ("OK to terminate '"+seqID+"'?")) {
                return false;
            }
            form.operation.value = 'rm_terminate';  
        }
        if('sendAckReq' == oper)
        {
            if (!confirm ("OK to send acknowledgement request'"+seqID+"'?")) {
                return false;
            }
            form.operation.value = 'rm_sendAckReq'; 
        }
        form.serverSequenceId.value = seqID;
        return true
    }
  </script>
 </head>
  <body onLoad="setNavigation('settings-rm.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_ReliableMessagingScrn');">
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2"> Settings &gt; Web Services &gt; Reliable Messaging </td>
        </tr>
         %ifvar operation equals('rm_close')%
            %invoke wm.server.ws:closeSequence%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif%   
        %ifvar operation equals('rm_terminate')%
            %invoke wm.server.ws:terminateSequence%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('rm_sendAckReq')%
            %invoke wm.server.ws:sendAcknowledgementRequest%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        %ifvar operation equals('edit_rm_props')%
            %invoke wm.server.ws:setReliableMessagingConfiguration%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
        %endif% 
        
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<script>
					createForm("htmlform_settings_wsendpoints", "settings-wsendpoints.dsp", "POST", "BODY");
					createForm("htmlform_settings_rm_edit", "settings-rm-edit.dsp", "POST", "BODY");
					</script>
                    <li class="listitem"><script>getURL("settings-wsendpoints.dsp", "javascript:document.htmlform_settings_wsendpoints.submit();", "Return to Web Services");</script>
					
					</li>
                    <li class="listitem"><script>getURL("settings-rm-edit.dsp", "javascript:document.htmlform_settings_rm_edit.submit();", "Edit Reliable Messaging Configuration");</script>
					
					</li>
                    
                </ul>
            </td>
        </tr>
        %invoke wm.server.ws:getReliableMessagingReport%
            <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>    
                            <table class="tableView" width="100%">
                                <tr>
                                    <td class="heading" colspan="10">Client Sequences</td>
                                </tr>
                                <tr>
                                    <th scope="col" class="oddcol-l">User Sequence Key</th>
                                    <th scope="col" class="oddcol">Client Sequence Id</th>
                                    <th scope="col" class="oddcol">Server Sequence Id</th>
                                    <th scope="col" class="oddcol">To Address</th>
                                    <th scope="col" class="oddcol">Status</th>
                                    <th scope="col" class="oddcol">Number of Completed Messages</th>
                                    <th scope="col" class="oddcol">Last Activated</th>
                                    <th scope="col" class="oddcol">Acknowledgement Request</th>
                                    <th scope="col" class="oddcol">Close</th>
                                    <th scope="col" class="oddcol">Terminate</th>
                                </tr>
                                
                                    %loop reliableMessagingReport/clientRMSequenceReports%
                                        <tr>
                                            <script>writeTD("row-l");</script>
												%value sequenceKey encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value clientSequenceId encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value serverSequenceId encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value toAddress encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value statusMessage encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value numberOfCompletedMessages encode(html)%  
                                            </td>
                                            <script>writeTD("row-l");</script>
												%value lastActivatedTime encode(html)%  
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                                %ifvar status equals('4')%
                                                    <p style="text-decoration:underline;color:grey">Send</p>
                                                %else%
                                                    %ifvar status equals('3')%
                                                        <p style="text-decoration:underline;color:grey">Send</p>
                                                    %else%
														<a href="javascript:document.htmlform_sendAckReq.submit();" onClick="return populateForm(document.htmlform_sendAckReq,'%value serverSequenceId encode(javascript)%','sendAckReq');">
                                                            Send
                                                        </a>
                                                    %endif%
                                                %endif%
                                            </td>
                                            <script>writeTD("rowdata");</script>
                                                %ifvar status equals('2')%
													<a href="javascript:document.htmlform_close.submit();" onClick="return populateForm(document.htmlform_close,'%value serverSequenceId encode(javascript)%','close');">
                                                        Close
                                                    </a>
                                                %else%
                                                    <p style="text-decoration:underline;color:grey">Close</p>
                                                %endif%
                                            </td>                       
                                            <script>writeTD("rowdata");</script>
                                                %ifvar status equals('4')%
                                                    <p style="text-decoration:underline;color:grey">Terminate</p>
                                                %else%
                                                    %ifvar status equals('3')%
                                                        <p style="text-decoration:underline;color:grey">Terminate</p>
                                                    %else%
														<a href="javascript:document.htmlform_terminate.submit();" onClick="return populateForm(document.htmlform_terminate,'%value serverSequenceId encode(javascript)%','terminate');">
                                                            Terminate
                                                        </a>
                                                    %endif%
                                                %endif%
                                            </td>
                                        </tr>
                                        <script>swapRows();</script>
                                    %endloop%
                            
                            </table>
                            
                            <br/>

                            <script>resetRows();</script>

                            <table class="tableView" width="100%">
                                <tr>
                                    <td class="heading" colspan="6">Server Sequences</td>
                                </tr>
                                <tr>
                                    <th scope="col" class="oddcol-l">Server Sequence Id</th>
                                    <th scope="col" class="oddcol">Client Sequence Id</th>
                                    <th scope="col" class="oddcol">To Address</th>
                                    <th scope="col" class="oddcol">Status</th>
                                    <th scope="col" class="oddcol">Number of Completed Messages</th>
                                    <th scope="col" class="oddcol">Last Activated</th>
                                </tr>
                                
                                %loop reliableMessagingReport/serverRMSequenceReports%
                                    <tr>
                                        <script>writeTD("row-l");</script>
											%value serverSequenceId encode(html)%  
                                        </td>
                                        <script>writeTD("row-l");</script>
											%value clientSequenceId encode(html)%  
                                        </td>
                                        <script>writeTD("row-l");</script>
											%value toAddress encode(html)%  
                                        </td>
                                        <script>writeTD("row-l");</script>
											%value statusMessage encode(html)%  
                                        </td>
                                        <script>writeTD("row-l");</script>
											%value numberOfCompletedMessages encode(html)%  
                                        </td>
                                        <script>writeTD("row-l");</script>
											%value lastActivatedTime encode(html)%
                                        </td>
                                    </tr>
                                    <script>swapRows();</script>
                                %endloop%
                            
                            </table>
                            
                            
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        %endinvoke%
    </table>
    <form name="htmlform_close" action="settings-rm.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="serverSequenceId">
    </form>
    <form name="htmlform_terminate" action="settings-rm.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="serverSequenceId">
    </form>
    <form name="htmlform_sendAckReq" action="settings-rm.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="serverSequenceId">
    </form>
    </body>     
</html>
