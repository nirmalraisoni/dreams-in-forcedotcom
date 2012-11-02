global class Helper_ObjectCreator {
 
	public static audit__c audit(){
		audit__c audit = new audit__c();
		 audit.category__c = 'Any Cat';
		 audit.type__c = 'Any Type';
		 audit.value__c = 3444.44;
		return audit;
		
	}

}