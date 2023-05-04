@isTest
private class ReportScheduleTestClass {
   
@isTest(SeeAllData = true)
    static  void schedulerTest(){
         
        String cronexpression = '0 0 0 15 3 ? *';
  
         
        Test.startTest();
       
        
        String jobId = System.schedule('ScheduleBatchApexClass',  cronexpression, new ReportSchedulerClass());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cronexpression, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
       
        List<Report> reportList=[select id, name from report Limit 1];

         string reportId=(string) reportList.get(0).get('Id');
       reports.ReportResults reportResult=reports.ReportManager.runReport(reportId, true);
    
        Test.stopTest();
        
       
        
    }


}