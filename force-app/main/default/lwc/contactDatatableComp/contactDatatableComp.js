import { LightningElement ,track,api,wire} from 'lwc';
import getConList from '@salesforce/apex/getContacts.getConList';
import { updateRecord } from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import LASTNAME from '@salesforce/schema/Contact.LastName';
import ID from '@salesforce/schema/Contact.Id';
const colm =[
    {label:'FirstName' ,fieldName :'FirstName' , type:'text',editable :true},
    {label:'LastName' ,fieldName :'LastName' , type:'text',editable :true},
    {label:'Id' ,fieldName :'Id' , type:'text',editable :true}
];

export default class ContactDatatableComp extends LightningElement {
    @track col = colm ;
    @track rupom ;
     draftValues =[];
     
     @wire(getConList)rupom ;

    handleSave(event){
        this.draftValues = event.detail.draftValues;
            const inputsItems = this.draftValues.slice().map(draft => {
                const fields = Object.assign({}, draft);
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
                message: 'An Error Occured!!',
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
   
   
