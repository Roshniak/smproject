trigger LeadTrigger on Lead (before insert ,before Update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    {
        Set<String> leadCompany = new Set<String>();
        	
        for(Lead l : Trigger.New)
        {
           leadCompany.add( l.Company);
        }
        
    List<Account> accList =[Select Id ,Name  from Account where Name IN : leadCompany];
        if(! accList.isEmpty())
        {
            for(Lead ld : trigger.new){
                
                ld.Lead_Type__c ='Existing Customer';
            }
        }
        else{
             for(Lead ld : trigger.new){
                
                ld.Lead_Type__c ='New Customer';
            }
            
        }
    }
    

}