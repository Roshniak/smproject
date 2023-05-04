trigger ContractTrigger on Contract (before insert ) { 
    if(Trigger.isBefore &&(Trigger.isInsert || trigger.isUpdate))
       {
           List<Opportunity> OppList = [Select Id from Opportunity where Id IN 
                                        (Select Opportunity__c from Contract)];
           List<Id> OppIds = new List<Id>();
           for(Opportunity opp : OppList){
               OppIds.add(opp.Id);
           }
           for(Contract con : Trigger.New){
               if( OppIds.contains(con.Opportunity__c))
               {
                  con.addError('Opportunity can  have only one Contract'); 
               }
           }
       }
}