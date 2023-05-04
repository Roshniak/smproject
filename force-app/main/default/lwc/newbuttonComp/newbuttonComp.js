import { LightningElement ,api ,track ,wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getTask from '@salesforce/apex/getLeadTask.getTask';
const colm =[
  
    {label: 'Task Created By Name',fieldName:'CreatedById'},
    {label: 'Meeting Attented By ',fieldName:'Meeting_Attended_By__c'},
    {label: 'Meeting Comments',fieldName:'Description' , editable : true},
    {label: 'Updated Time',fieldName:'Task_Updated_By__c'},
    {label:'Record Id',fieldName :'whoId'}
]
 

export default class NewbuttonComponent extends NavigationMixin( LightningElement ) { 
    @track col = colm ;                                                                                        
_recordId;
   @api set recordId(value){
    this._recordId = value ;
   console.log(+ this._recordId);
   }
   get recordId(){
    return this._recordId;
    console.log(+ this._recordId);
   }
   @wire(getTask ,{LeadId :'$_recordId'})rupom({error,data})
   {if(data)
   {this.rec =data;
   console.log(+this.rec);
   }};

    
}
  