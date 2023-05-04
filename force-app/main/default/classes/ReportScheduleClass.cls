Global class ReportScheduleClass implements Database.Batchable <Sobject>
{
global database.querylocator start(Database.BatchableContext bContext)
{
             string reportList='Select id, name from Report';
              return Database.getQueryLocator(reportList) ;   
}
  
global void execute(Database.BatchableContext bContext, List<Report> reportsToSchedule)
 {
     if(! reportsToSchedule.isEmpty())
         {
           for(Report rp :reportsToSchedule )
             {
                 
                 string reportId=(string) rp.get('Id');

                 reports.ReportResults reportResult=reports.ReportManager.runReport(reportId, true);
                 System.debug(reportResult);
             }
         }
   
 
}
  
global void finish(Database.BatchableContext bContext)
 {
       
    
}

}