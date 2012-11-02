public class Helper_BusinessRules {


	public static sobject enforceSingleItem(List<Sobject> objs){
		if(objs.size() > 1){
			throw new GenericException('This object can only be saved individually');
		}
		return objs.get(0);
	}
		 
	public static void enforceProfile(List<String> profiles){
		id profileId = System.Userinfo.getProfileId();
		Profile userProfile = [select id,name from Profile where id = :profileId limit 1];
		boolean found = false;
		
		for(string profile : profiles){
			if(profile == userProfile.name){
				found = true;
			}
		}
		if(!found){
			throw new GenericException('You need the following profile: ' + userProfile.Name);
		}
	}

}