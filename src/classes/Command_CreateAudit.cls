public class Command_CreateAudit implements InterfaceCommand {

	public Audit__c audit;
	
	public string action = 'insert';

	public Command_CreateAudit(string id,string category, string type , decimal value){
		this.audit = new Audit__c();
		this.audit.RelatedObject__c = id;
		this.audit.category__c = category;
		this.audit.type__c = type;
		this.audit.value__c = value;
	}

	public string getAction(){
		return action;
	}
	
	public sobject execute(){
		return Audit;
	} 

}