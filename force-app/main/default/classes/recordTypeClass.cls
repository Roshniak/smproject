public class recordTypeClass {
    @AuraEnabled(Cacheable =True)
    public static String findRecordTypeId(String rectypename)
    {
        List<RecordType> recList = new List<RecordType>();
      for(RecordType rt :[Select Id ,Name from RecordType where Name =:rectypename Limit 1])
      {
          recList.add(rt);
      }
        System.debug(recList[0].Id);
        String recId =recList[0].Id;
        return recId;
    }

}