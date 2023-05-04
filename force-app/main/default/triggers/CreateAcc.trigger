trigger CreateAcc on Contact ( after insert) { /*
    
    if(Trigger.isAfter && Trigger.isInsert)
    {
        List <Account> accList = new  List <Account>();
        List <Contact> NewconList = new  List <Contact>();
        List<Contact> conList =[Select Id ,LastName ,AccountId from Contact where Id IN : Trigger.newMap.keyset()];
        if(! conList.isEmpty())
        {
            for(Contact con : conList)
            {
                Account acc = new Account( Name = con.LastName );
                accList.add(acc);
                
                
            }
        }
        
        
        if(!  accList.isEmpty())
        {
            insert accList ;
        }
        
        Map<String ,Id> accIdNameMap = new  Map<String ,Id>();
        for(Account acc : accList)
        {
            accIdNameMap.put(acc.name ,acc.Id);
        }
        
         for(Contact con : conList)
            {
                con.AccountId = accIdNameMap.get(con.LastName);
        NewconList.add(con);
        
    }
       Update NewconList;
    
}  */ }