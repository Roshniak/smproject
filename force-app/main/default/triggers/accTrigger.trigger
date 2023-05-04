trigger accTrigger on Account (before Insert) {
    if(trigger.isBefore && trigger.isInsert)
    { Set<String> accName = New Set<String>();
        for(Account acc : trigger.new)
        {
            accName.add(acc.Name);
        }
     List<Account> accList = [Select Id ,Name from Account where Name IN :accName];
     if(! accList.isEmpty()){
         for (Account ac : trigger.New)
         {
             ac.Name.addError('Account name is repeated');
         }
     }
    }

}