public class LeadConvertHandlerClass {
    public static List<String> lcompany = new List<string>();
    public static List<Lead>  leadlist = new List<Lead>();
    public static Map<string,Id> accIdleadcompany = new  Map<string,Id>();
    
    public static void getLeads(List<Task> newTask){
        Set<Id> leadIds = new Set<Id>();
        for(Task t :newTask)
        {
            if(t.Status =='Completed-Won')
            {
                leadIds.add(t.WhoId);
            }
            if(t.Status =='Completed-Lost')
            {
                Lead lrecord = new Lead(Id = t.WhoId ,Status ='Closed-Not Converted' );
            }
        }
        leadlist =[Select Id ,Status ,Lead_Type__c , IsConverted,Company from Lead where Id IN :leadIds ];
        
        for(lead leadcomp : leadlist)
        {
            lcompany.add(leadcomp.Company);
        }
        List<Account> accountList = [Select Id ,Name from Account where Name IN : lcompany];
        
        if(! leadlist.isEmpty())
        {
            for( Account ac :accountList )
            {
                accIdleadcompany.put(ac.Name ,ac.Id);
            }
        }
        
    }
    
    public static void convertLeads(){
        LeadStatus lstatus = [Select id ,MasterLabel ,IsConverted from LeadStatus where IsConverted = True];
        List<Database.LeadConvert> convertedLeads = new List<Database.LeadConvert>();
        
        if(! leadlist.isEmpty()){
            for(Lead l : leadlist)
            { if(l.status=='Closed - Converted' && l.IsConverted == false)
            { 
                if(  l.Lead_Type__c =='New Customer')
                {
                    Database.LeadConvert lconvert = new Database.LeadConvert();
                    lconvert.setLeadId(l.Id);
                    lconvert.setDoNotCreateOpportunity(false);
                    lconvert.setSendNotificationEmail(True);
                    lconvert.setConvertedStatus(lstatus.MasterLabel);
                    
                    convertedLeads.add(lconvert);
                }
                if(l.Lead_Type__c =='Existing Customer' )
                {
                    Database.LeadConvert lconvert = new Database.LeadConvert();
                    lconvert.setLeadId(l.Id);
                    lconvert.setDoNotCreateOpportunity(false);
                    lconvert.setSendNotificationEmail(True);
                    lconvert.setConvertedStatus(lstatus.MasterLabel);
                    Account acc =new Account(Id = accIdleadcompany.get(l.Company) ) ;
                    Opportunity opp =new Opportunity (AccountId = acc.Id ,Type ='Existing Customer - Upgrade');
                    lconvert.setAccountId(acc.Id);
                    lconvert.setOpportunityId(opp.Id);
                 
                    convertedLeads.add(lconvert);  
                }
                
            }
            }
            
          if(! convertedLeads.isEmpty())
            {
                Database.LeadConvertResult[] result = Database.ConvertLead(convertedLeads);
                System.debug(''+ result);
            }
        }
            
  }
          
}