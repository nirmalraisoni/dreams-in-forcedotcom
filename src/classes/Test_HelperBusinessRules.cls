@isTest
private class Test_HelperBusinessRules {

	static testMethod void test_enforceProfile() {
		 Helper_BusinessRules.enforceProfile(new List<String>{'Platform System Admin' , 'Database.com Admin User'});
		
		
		 exception teste;
	    try{
		 Helper_BusinessRules.enforceProfile(new List<String>{'Any Admin'});
        }
        catch(exception e){
          teste = e;
        }
        System.assertNotEquals(teste,null);
    
	}

	static testMethod void test_enforceSingleItem() {
	    audit__c audit1 = Helper_ObjectCreator.audit();
        audit__c audit2 = Helper_ObjectCreator.audit();
        insert audit1;
        List<audit__c> audits = [select id,category__c from audit__c];
    
    	Helper_BusinessRules.enforceSingleItem(audits);
    	
    	insert audit2;
        audits = [select id,category__c from audit__c];

	    exception teste;
	    try{
          Helper_BusinessRules.enforceSingleItem(audits);
        }
        catch(exception e){
          teste = e;
        }
        System.assertNotEquals(teste,null);
    
	}

  
}