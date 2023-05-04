import { LightningElement ,track,api,wire} from 'lwc';
import getTask from '@salesforce/apex/GetLeadTask.getTask';
import UpdateTask from '@salesforce/apex/UpdateTaskofLead.UpdateTask';
import { updateRecord } from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import TASK_OBJECT from '@salesforce/schema/Task';
import ID_FIELD from '@salesforce/schema/Task.Id';
import CREATE_FIELD from '@salesforce/schema/Task.CreatedById';
import MEETATTEND_FIELD from '@salesforce/schema/Task.Meeting_Attended_By__c';
import COMMENT_FIELD from '@salesforce/schema/Task.Description';
import TASKUPDATE_FIELD from '@salesforce/schema/Task.Task_Updated_By__c';
import Id from '@salesforce/user/Id';

const colm =[
    {label: 'Id of task',fieldName:ID_FIELD.fieldApiName, editable : true},
    {label: 'Task Created By Name',fieldName:CREATE_FIELD.fieldApiName, editable : true},
    {label: 'Meeting Attented By ',fieldName:MEETATTEND_FIELD.fieldApiName, editable : true},
    {label: 'Meeting Comments',fieldName:COMMENT_FIELD.fieldApiName, editable : true},
    {label: 'Updated Time',fieldName:TASKUPDATE_FIELD.fieldApiName, editable : true}
];

export default class ContactDatatableComp extends LightningElement {
    @track col = colm ;
    @track rupom ;
     draftValues =[];
     @api recordId ;
     userId = Id ;
     
     
@wire(getTask ,{leadId :'$recordId'})rupom;
@wire(UpdateTask ,{leadId :'$recordId',IdofUser : '$userId'})rup;

    handleSave(event){
        this.draftValues = event.detail.draftValues;
            const inputsItems = this.draftValues.slice().map(draft => {
                const fields =Object.assign({}, draft);
                return { fields };
            });
     
           
            const promises = inputsItems.map(recordInput => updateRecord(recordInput));
            Promise.all(promises).then(res => {
             this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Records Updated Successfully!!',
                variant: 'success'
            })
        );
        this.draftValues = [];
        return this.refresh();
    }).catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'An Error Occured!!'+error.body.message ,
                variant: 'error'
            })
        );
    }).finally(() => {
        this.draftValues = [];
    });
}


async refresh() {
    await refreshApex(this.rupom);
}
}
   
   
