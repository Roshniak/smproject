trigger ContactTrigger on Contact (before update) {
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        Map<Id,String> OldPhoneMap = new  Map<Id,String>();
        Map<Id,String> OldEmailMap = new  Map<Id,String>();
        Map<Id,String> OldDescriptionMap = new  Map<Id,String>();
        for(Contact con : Trigger.Old)
        {
            if(con.Email != Null && con.Phone != Null)
            {
                OldPhoneMap.put(con.id ,con.Phone) ;
                OldEmailMap.put(con.Id ,con.Email);
                OldDescriptionMap.put(con.id ,con.Description);
            }
        }
        
        Map<Id,String> NewPhoneMap = new  Map<Id,String>();
        Map<Id,String> NewEmailMap = new  Map<Id,String>();
        for(Contact con : Trigger.New)
        {
            
                if(con.Email != OldEmailMap.get(con.id))
                {
                    NewEmailMap.put(con.Id ,con.Email);
                    con.Description = UserInfo.getFirstName()+ ' '+' updated Email from '+' '+ OldEmailMap.get(con.Id) +' to '+ NewEmailMap.get(con.Id)
                        +' '+ System.today() +'. '+ OldDescriptionMap.get(con.Id);
                }}
                
         for(Contact con : Trigger.New)
        {
                if (con.Phone != OldPhoneMap.get(con.id))
                {
                    NewPhoneMap.put(con.Id ,con.Phone);
                    con.Description = UserInfo.getFirstName() + ' '+'updated Phone from '+' '+OldPhoneMap.get(con.Id) +' to '+ NewPhoneMap.get(con.Id)
                         +' '+ System.today() +'. '+ OldDescriptionMap.get(con.Id);
                }
                
            
        }
    }
    
}