public class getTask {
     List<Lead> listlead = new List<lead>();
    public string taskidvalue = ApexPages.currentPage().getParameters().get('id');
 public String approveStatus = ApexPages.currentPage().getParameters().get('approved');  
    
    
    public  void getTaskrecord(){
         System.debug(ApexPages.currentPage().getParameters().get('id'));
        System.debug(ApexPages.currentPage().getParameters().get('verifyLead'));
         System.debug('approveStatus: ' + approveStatus);
        try{
        listlead =[Select Id, Activity_Status__c from Lead  where Id =: taskidvalue Limit 1];
           
        List<Lead> updatedlead = new List<Lead>();
        if(! listlead.isEmpty() & approveStatus =='yes')
        {
             for( Lead t : listlead)
          {
            t.Activity_Status__c ='Accept';
            updatedlead.add(t);
          }
       }
           
        
        update updatedlead ;
             List<Task> tk = [Select Id , Status ,whoId from Task where whoId IN : updatedlead];
            List<Task> updateTask = new List<Task>();
             if(! tk.isEmpty() )
             { for(Task t : tk)
             {
                 t.Status ='Meeting Accepted by the Dealer';
                 updateTask.add(t);
             }
                 
             }
            update updateTask;
            List<Lead> newLeadStatus = new List<Lead>();
            for( Task taskk :updateTask)
            {
                if(taskk.Status =='Meeting Completed')
                { for( lead ld :listlead)
                { if( taskk.whoId == ld.Id)
                {
                    ld.Status ='Closed - Converted';
                }
                   newLeadStatus.add(ld);
                }
                }
                
                
            }
            update newLeadStatus;
            
            
         } catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        }         
        
    }

}