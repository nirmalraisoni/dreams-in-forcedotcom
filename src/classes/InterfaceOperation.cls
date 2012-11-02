public abstract class InterfaceOperation {
  
  protected List<InterfaceCommand> commands;
  protected List<sobject> insertable;
  protected List<sobject> updatable;
  Map<String,String> keys;
  
 public InterfaceOperation(){
 	commands = new List<InterfaceCommand>();
 	insertable = new List<sobject>();
 	updatable = new List<sobject>();
  } 
 
  public virtual void setCommands(){
  }

  public void execute(){
  	for(InterfaceCommand command : commands){
  		this.executeCommand(command);
  	}
  	
  	if(updatable.size() > 0){ 
  		List<List<sobject>> updatables =  groupByType(updatable);
  		for(List<Sobject> updatableList : updatables){
  			update updatableList;
  		}
  	}
  	
  	if(insertable.size() > 0){
  		List<List<sobject>> insertables =  groupByType(insertable);
  		for(List<Sobject> insertableList : insertables){
  			insert insertableList;
  		}
  	}
  }

   private List<List<sobject>> groupByType(List<sobject> master){
     Map<String,List<Sobject>> mapTipoToSobject = new Map<String,List<Sobject>>();
     for(Sobject obj : master){
     	string tipo = obj.getSObjectType().getDescribe().getName();

     	List<Sobject> mappedObjects = mapTipoToSobject.get(tipo); 
     	if(mappedObjects==null){
     		mappedObjects = new List<Sobject>();
     	}
     	mappedObjects.add(obj);
     	mapTipoToSobject.put(tipo,mappedObjects); 
     }
       return mapTipoToSobject.values();
   }

 	
  void executeCommand(InterfaceCommand command){
  	if(command.getAction() == 'update'){
  		sobject obj = command.execute();
  		updatable.add(obj);
  	}
  	else if(command.getAction() == 'insert'){
  		insertable.add(command.execute());
  	}
  	else{
  		command.execute();
  	}
  }

}