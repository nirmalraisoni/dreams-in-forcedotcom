public class Command_UpdateObjectField  implements InterfaceCommand {

	public sobject obj;
	public string field;
	public object value;
	public string action = 'update';

	public Command_UpdateObjectField(sobject obj, string field,object value,string action){
		this.obj = obj;
		this.field= field;
		this.value = value;
		this.action = action;
	}
	
	public string getAction(){
		return action;
	}
	
	public sobject execute(){
		obj.put(field,value);
		return obj;
	}



}