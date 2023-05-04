public class OppAcknowledgeHandler {
    public static void getOpp(){
       string oppidvalue = ApexPages.currentPage().getParameters().get('id');
       String approveStatus = ApexPages.currentPage().getParameters().get('approved'); 
        
        List<Opportunity> oppList =[Select Id ,Acknowledge__c from Opportunity where Id =:oppidvalue ];
         List<Opportunity> oppListUpdated = new  List<Opportunity> ();
        if( approveStatus=='yes' )
        {
            for(Opportunity op :oppList){
                op.Acknowledge__c = 'yes';
                oppListUpdated.add(op);
            }
        } 
        else if(  approveStatus=='No' )
        {
            for(Opportunity op :oppList){
                op.Acknowledge__c = 'No';
                oppListUpdated.add(op);
            }
        }
        update oppListUpdated;
    }

}