public with sharing class getProduct {
    
        @AuraEnabled(cacheable=true)
        public static List<Product2>  getProductList(){
           return [Select Id , Name , IsActive , Family , ProductCode ,Cost__c ,Product_Image__c from Product2
            where IsActive = true];
    }
    
}