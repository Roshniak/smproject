public class QuoteAcknowledgementController {
    public void updateOpportunityStatus(){
                System.debug(ApexPages.currentPage().getParameters().get('id'));
        
         try{
            Opportunity opp =[Select Id ,StageName  from Opportunity where Id =: ApexPages.currentPage().getParameters().get('id') LIMIT 1];
            if(opp != null)
            {    string ak =  ApexPages.currentPage().getParameters().get('acknowledge');
               if( ak =='yes') 
            { opp.StageName = 'Closed Won';
            }
            }
            Update opp ;
        }
        
        catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        } 
        
    }

}