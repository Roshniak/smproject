public with sharing class getContacts {
    @AuraEnabled(cacheable=true)
    public static List<Contact>  getConList(){
       return [Select Id ,FirstName ,Lastname ,Phone ,Email from Contact];
}
}