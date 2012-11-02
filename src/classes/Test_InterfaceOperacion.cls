@isTest
private class Test_InterfaceOperacion {

    static testMethod void testInterface() {

		
		InterfaceOperation sampleInterface = new Operation_Generic();
		sampleInterface.setCommands();
		sampleInterface.execute();
		
    }
}