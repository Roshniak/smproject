public class GetLeadTask {
  

    @AuraEnabled(cacheable = true)
    public static List<Task>  getTask(string leadId ){
    string LdId = leadId ;
     
  
  
       
    List<Task> taskList = [Select Id ,CreatedById ,Description ,WhoId ,Task_Updated_By__c ,Meeting_Attended_By__c  
       from Task where WhoId = : LdId];

       
    
    return taskList ;
   
    
}


}