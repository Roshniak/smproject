trigger TaskTrigger on Task (after Update ) {
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        LeadConvertHandlerClass.getLeads(Trigger.New);
        LeadConvertHandlerClass.convertLeads();
       }
        
        }