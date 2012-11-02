public class Command_SinglePush implements InterfaceCommand {

	List<Sobject> sobjects;
	public string channel;

	public Command_SinglePush(sobject obj , string channel){
		sobjects = new List<Sobject>();
		sobjects.add(obj);
		this.channel = channel;
	}

	public Command_SinglePush(List<sobject> objs , string channel){
		this.sobjects = objs;
		this.channel = channel;
	}
	
	public string getAction(){
		return 'no action';
	}
	
	public sobject execute(){
		string jsonObj = Helper_Pusher.ListToJson(sobjects);
		Helper_Pusher.push('salesforce_data_push', channel , jsonObj);
		return sobjects.get(0);
	} 
}