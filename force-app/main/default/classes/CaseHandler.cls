public class CaseHandler {
    public static void caseAssign(List<Case> newCases){
        // Get CustomMetadata Records
        List<Case_Assignment__mdt> cas = Case_Assignment__mdt.getall().values();
        
        List <Group> queueId =[Select Id ,Name , Type from Group where Type ='Queue' ];
       
        //map queue Name & Id in Map
        Map<String ,Id> queueIdNamemap = new Map<String ,Id>(); 
               for(Group q :queueId)
        {
            queueIdNamemap.put(q.Name ,q.Id);
        }
        
        //Assign  cases with Queue
        for(Case cs :newCases )
        {
            for(Case_Assignment__mdt CA :cas)
            {
                if(cs.Sub_Type__c == CA.Sub_Type__c && cs.RecordTypeId ==CA.Record_Type__c &&
                   cs.Status == CA.Status__c )
                {
                    cs.OwnerId = queueIdNamemap.get(CA.Queues__c) ;
                }
                
            }
        }
    }}