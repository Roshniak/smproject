public with sharing class UpdateTaskofLead {
    @AuraEnabled
public static List<Task>  UpdateTask(string leadId  , string IdofUser){

    List<Task> taskList = [Select Id ,CreatedById ,Description ,WhoId ,Task_Updated_By__c ,Meeting_Attended_By__c  
    from Task where WhoId = : leadId];


    String idofus = IdofUser;
       
       List<Task> tkUpdateList = new List<Task>();

       for(Task tk : taskList){
        tk.Meeting_Attended_By__c = idofus;
        tkUpdateList.add(tk);
       }
       update tkUpdateList ;
    
    return tkUpdateList ;
    
}
}