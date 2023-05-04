Global class ReportSchedulerClass implements System.Schedulable {
    
    Global void Execute (System.SchedulableContext sContext)
    {    ReportScheduleClass   ScheduledReports =new ReportScheduleClass();
        Database.executeBatch(ScheduledReports);
    }

}