@isTest
private class TestgetContract {
    
    public static testmethod void  testcon (){
        string contractId ='8002w000001oB61AAE';
        Test.startTest();
        getContract.getContractrecord(contractId);
        Test.stopTest();
        Contract c =[Select id ,Status from Contract where Id =:contractId];
        System.Assert(c.Status == 'Activated');
    } 

}