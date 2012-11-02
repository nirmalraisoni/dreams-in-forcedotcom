public without sharing class Operation_Generic extends InterfaceOperation {  

	public Operation_Generic(){
	}

	public override void setCommands(){ 
	
		audit__c audit1 = Helper_ObjectCreator.audit();
        audit__c audit2 = Helper_ObjectCreator.audit();
        insert audit1;
        insert audit2;
		
		this.commands.add( new Command_CreateAudit(audit1.id,'One','Single',100.45 ) );
		this.commands.add( new Command_UpdateObjectField(audit2,'Category__c' , 'Testing Change' , 'update') );
		this.commands.add( new Command_SinglePush(audit2,'Audit__c') );
		this.commands.add( new Command_SinglePush(new List<Audit__c>{audit1,audit2},'Audit__c') );
			

	}
}