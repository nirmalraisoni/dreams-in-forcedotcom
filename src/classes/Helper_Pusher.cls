public class Helper_Pusher {

    public class PusherException extends Exception {
    }

   
   	public static string ListToJson(List<sobject> sobjects){
   		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
		gen.writeStringField('user', UserInfo.getUserId());
		gen.writeFieldName('sobjects');
		gen.writeObject(sobjects);	
        gen.writeEndObject();
		String jsonObj = gen.getAsString();
		return jsonObj;
   	}


    @Future(callout=true) public static void push(String channel, String name, String message) {
        Helper_Pusher.prepareRequest(channel, name, message);
    }
     
    public static void prepareRequest(String channel, String name, String message) {
        string authKey = GlobalVariables.PUSHER_KEY;
        string authSecret = GlobalVariables.PUSHER_SECRET;
        string appid = GlobalVariables.PUSHER_APP_ID;
        
        String authTimestamp = String.valueOf(Datetime.now().getTime() / 1000);
        String authVersion = '1.0';
        String bodyMd5 = EncodingUtil.convertToHex(Crypto.generateDigest('MD5' , Blob.valueOf(message)));
        String path = '/apps/'+appid+'/channels/'+channel+'/events';

        String stringToSign = 'POST\n'+path+'\nauth_key='+authKey+
            '&auth_timestamp='+authTimestamp+'&auth_version='+authVersion+
            '&body_md5='+bodyMd5+'&name='+name;

        String authSignature =
            EncodingUtil.convertToHex(Crypto.generateMac('hmacSHA256',
              Blob.valueOf(stringToSign), Blob.valueOf(authSecret)));

        String endpoint = 'https://api.pusherapp.com'+path+
            '?auth_key='+authKey+
            '&auth_timestamp='+authTimestamp+
            '&auth_version='+authVersion+
            '&body_md5='+bodyMd5+
            '&name='+name+
            '&auth_signature='+authSignature;

        HttpRequest req = new HttpRequest(); 

        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setBody(message);    

		Helper_Pusher.doRequest(req);
    }
    
    public static void doRequest(HttpRequest req){
		if (Test.isRunningTest() == false){
			new Http().send(req);
		}
    }
    
}