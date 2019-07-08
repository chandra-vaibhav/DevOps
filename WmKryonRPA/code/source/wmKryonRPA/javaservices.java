package wmKryonRPA;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.util.security.WmSecureString;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import com.wm.app.b2b.server.OutboundPasswordManager;
import com.wm.app.b2b.server.Server;
import com.wm.app.b2b.server.ServerAPI;
// --- <<IS-END-IMPORTS>> ---

public final class javaservices

{
	// ---( internal utility methods )---

	final static javaservices _instance = new javaservices();

	static javaservices _newInstance() { return new javaservices(); }

	static javaservices _cast(Object o) { return (javaservices)o; }

	// ---( server methods )---




	public static final void getConfiguration (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConfiguration)>> ---
		// @sigtype java 3.5
		// [o] recref:0:required Configuration wmKryonRPA.docs:Configuration
		 
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();		
		
		Properties props = getProperties("WebAPIConnection.properties");
		
		String kryonWebAPIURL = props.getProperty("KryonWebAPIURL", "http://localhost:8080/");		
		String userName = props.getProperty("userName", "WebAPIUser");
		String password = getPasswordFromOPM();
		
		// Configuration
		IData	Configuration = IDataFactory.create();
		IDataCursor ConfigurationCursor = Configuration.getCursor();
		IDataUtil.put( ConfigurationCursor, "KryonWebAPIURL", kryonWebAPIURL );
		IDataUtil.put( ConfigurationCursor, "UserName", userName);
		IDataUtil.put( ConfigurationCursor, "Password", password);
		ConfigurationCursor.destroy();
		IDataUtil.put( pipelineCursor, "Configuration", Configuration );
		pipelineCursor.destroy();
		
		
				
		// --- <<IS-END>> ---

                
	}



	public static final void getErrorDescription (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getErrorDescription)>> ---
		// @sigtype java 3.5
		// [i] object:0:required ErrorId
		// [o] object:0:required ErrorId
		// [o] field:0:required ErrorDescription
		 
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	errorId = IDataUtil.getString( pipelineCursor, "ErrorId" );
		
		Properties props = getProperties("ErrorDescription.properties");
		
		String errorDescription = props.getProperty("error" + errorId, "N/A");		
		
		IDataUtil.put( pipelineCursor, "ErrorId", errorId );
		IDataUtil.put( pipelineCursor, "ErrorDescription", errorDescription );
		pipelineCursor.destroy();
		
				
		// --- <<IS-END>> ---

                
	}



	public static final void getStatusDescription (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getStatusDescription)>> ---
		// @sigtype java 3.5
		// [i] object:0:required StatusId
		// [o] object:0:required StatusId
		// [o] field:0:required StatusDescription
		 
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	statusId = IDataUtil.getString( pipelineCursor, "StatusId" );
		
		Properties props = getProperties("StatusDescription.properties");
		
		String statusDescription = props.getProperty("status" + statusId, "N/A");		
		
		IDataUtil.put( pipelineCursor, "StatusId", statusId );
		IDataUtil.put( pipelineCursor, "StatusDescription", statusDescription );
		pipelineCursor.destroy();
		
				
		// --- <<IS-END>> ---

                
	}



	public static final void setConfiguration (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setConfiguration)>> ---
		// @sigtype java 3.5
		// [i] recref:0:required Configuration wmKryonRPA.docs:Configuration
		// [o] field:0:required status
		 
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String status = "";
		
		// Configuration
		IData	Configuration = IDataUtil.getIData( pipelineCursor, "Configuration" );
		if ( Configuration != null)
		{
			IDataCursor ConfigurationCursor = Configuration.getCursor();
				String	KryonWebAPIURL = IDataUtil.getString( ConfigurationCursor, "KryonWebAPIURL" );
				String	UserName = IDataUtil.getString( ConfigurationCursor, "UserName" );
				String	Password = IDataUtil.getString( ConfigurationCursor, "Password" );
				Properties props = new Properties();
				props.put("KryonWebAPIURL", KryonWebAPIURL);
				props.put("userName", UserName);
				setProperties(props);
				
		            	setPasswordToOPM(Password);
		           		
				
				ConfigurationCursor.destroy();
		}
		
		
		IDataUtil.put( pipelineCursor, "status", status );
		pipelineCursor.destroy();
		
		
				
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static Properties getProperties(String fileName){
		File propertiesFile;
		Properties props = new Properties();
		propertiesFile = new File(Server.getResources().getPackageConfigDir("WmKryonRPA"), fileName);	    
		
	    try {		        
	        FileInputStream fis = new FileInputStream(propertiesFile);
	        props.load(fis);
	        fis.close();
	    }
	    catch (IOException e) {
	    	ServerAPI.logError((Throwable)e);	    	
	    }
	    
	    return props;
	}
	
	private static void setProperties(Properties props){
		File propertiesFile = new File(Server.getResources().getPackageConfigDir("WmKryonRPA"), "WebAPIConnection.properties");
	    
	    try {
	        
	        FileOutputStream fos = new FileOutputStream(propertiesFile);
	        props.store(fos, "WebAPIConnection");
	        fos.close();
	    }
	    catch (Exception e) {
	       ServerAPI.logError((Throwable)e);
	       
	    }
	    		
		
		
	}
	
	static String getPasswordFromOPM() {
	    String retString = "";
	    try {
	        WmSecureString cred = OutboundPasswordManager.retrievePassword("wm.is.wmkryonrpa.webapiuser");
	        if (cred == null) {
	            return "manage";
	        }
	        retString = cred.toString();
	    }
	    catch (Exception e) {
	    	ServerAPI.logError((Throwable)e);
	    }
	    return retString;
	}
	
	static void setPasswordToOPM(String password) {
	    try {
	        OutboundPasswordManager.storePassword("wm.is.wmkryonrpa.webapiuser", (WmSecureString)new WmSecureString(password));
	    }
	    catch (Exception e) {
	    	ServerAPI.logError((Throwable)e);
	    }
	}
		
	// --- <<IS-END-SHARED>> ---
}

