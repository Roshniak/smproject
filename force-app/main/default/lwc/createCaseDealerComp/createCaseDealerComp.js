import { LightningElement ,wire,track,api} from 'lwc';
import UserRole from '@salesforce/schema/user.UserRole__c';
import Id from '@salesforce/user/Id';
import USERCOMPNAME  from '@salesforce/schema/User.CompanyName';
import {getRecord}   from 'lightning/uiRecordApi';
import getUserAcc from '@salesforce/apex/AccountHandler.getUserAcc';



export default class CreateCaseDealerComp extends LightningElement {
   @track userRole = UserRole ;
   @track userId = Id ;
   @track compName = USERCOMPNAME;
  
   @track acc ;
   @track accName ;
   @track accId ;
   
   
   @wire(getRecord ,{recordId : Id , fields :[USERCOMPNAME]})currentUserInfo({error ,data})
   {
    if(data){
        this.compName =data.fields.CompanyName.value ;
        console.log('data :' +this.compName);
    }

   }


  
    @wire(getUserAcc ,{usercompanyname :'$compName'})acc({data,error}){
    if(data){
        this.acc = data;
       console.log('data of Account '+JSON.stringify(data));
        this.accName = data.Name;
        this.accId   = data.Id;
        this.error = undefined ;
    }
    else if(error){
        console.log(error);
    }

    
}
idofacc = this.accId;

/*
get status(){
    return this.acc.fields.Status.value ;
}
get Priority(){
    return this.acc.fields.Priority.value ;
} */

    
}