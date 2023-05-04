public class ContractAcknowledgeController {
     public void updateContract(){
              string conId = (ApexPages.currentPage().getParameters().get('id'));
                
         try{
           List< Contract> cont =[Select Id ,Status from Contract where (Id =:conId ) ];
             string ak =  ApexPages.currentPage().getParameters().get('approved');
              List< Contract> conUpdated = new  List< Contract>();
            if(cont != null)
            {  
                for(Contract con : cont )
                {
                     if( ak =='yes') 
            { con.Status = 'Activated';
            }
                }
             
              
            }
            Update conUpdated ;
        }
        
        catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        } 
        
    }

}