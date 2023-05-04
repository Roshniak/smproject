public class AccountHandler {
    
    public static void getAccount( List<Account> accOldList){
        System.debug('Trigger started');
        /* get all  contract with Account */
        List<Contract> ContractList = [Select Id , Status ,AccountId from Contract
                                         where status = 'Activated' AND AccountId IN :accOldList ];
        
        /* get Order with Account */
        List<Order> OrderList = [Select Id ,Status ,AccountId from Order where  Status ='Not Closed'
                                      AND AccountId IN :accOldList ];
        
        
         /*Add all Account */
       Set<Id> accSet = new Set<Id>();
        for(Contract con :ContractList)
        {
            accSet.add(con.AccountId);
        }
        
        for(Order od :OrderList)
        {
            accSet.add(od.AccountId);
        }
       
        /*get Accounts with Order and Contract */
         List<Account> accList = [Select Id from Account where Id IN : accSet];
        
        if(! accList.isEmpty())
        {
            for(Account acc : accOldList)
            {  
                if(accList.contains(acc))
            {  
                acc.addError('Account has associated Contract or Order. Cannot be Deleted');
            }
            }
            
        }
    }
    
@AuraEnabled(Cacheable =true)
    public static Account getUserAcc(String usercompanyname){
        return [Select Id ,Name  from Account WHERE Name =:usercompanyname] ;
    }
}