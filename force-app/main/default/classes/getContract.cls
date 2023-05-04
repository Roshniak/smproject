public class getContract {
  
    public string contractId = ApexPages.currentPage().getParameters().get('id');
 public   String approveStatus = ApexPages.currentPage().getParameters().get('approved');  
    
    
    public void getContractrecord(){
        /* System.debug('contractId :'+contractId);*/
   
       /*  System.debug('approveStatus: ' + approveStatus);*/
        try{
        List<Contract> updateCon = new List<Contract>();
           List<Contract> conrecord =[Select Id , Status ,ContractTerm from Contract where Id =:contractId LIMIT 1];
            for(Contract con : conrecord) 
            {
           con.Status ='Activated';
            updateCon.add(con);
           
            }
            update updateCon;
            
         } catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        }         
        

    }}