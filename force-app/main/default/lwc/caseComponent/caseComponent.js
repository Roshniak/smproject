import { LightningElement, track, wire, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Case';

import { getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';

import RECORDTYPEID from '@salesforce/schema/Case.RecordTypeId';
import ORIGN from '@salesforce/schema/Case.Origin'
import STATUS from '@salesforce/schema/Case.Status';
import PRIORITY from '@salesforce/schema/Case.Priority';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import findRecordTypeId  from '@salesforce/apex/recordTypeClass.findRecordTypeId';

export default class CreateContact extends LightningElement {
  selectedValue;
  @track statusOptions;
  @track value;
  @api objectApiName;

  @track objectInfo;
  @track rec;

  @track statusPicklist;
 @track selectedAccountId;
  @track caserecordId;    
  Orign = '';   
  status = '';  
  priority = '';
  

  @wire(getObjectInfo, { objectApiName: CONTACT_OBJECT,})
  objectInfo;


  get recordTypeId1() {
      var recordtypeinfo = this.objectInfo.data.recordTypeInfos;
      var uiCombobox = [];
      console.log("recordtype" + recordtypeinfo);
      for(var eachRecordtype in  recordtypeinfo)//this is to match structure of lightning combo box
      {
        if(recordtypeinfo.hasOwnProperty(eachRecordtype))
        uiCombobox.push({ label: recordtypeinfo[eachRecordtype].name, value: recordtypeinfo[eachRecordtype].name })
      }
      console.log('uiCombobox' + JSON.stringify(uiCombobox));
    return uiCombobox;
  }


    handleChangeRecordTpye(event){
     console.log('here is Console 2') ;
      this.selectedvalue =event.detail.value;
       
        console.log( 'New Value selected is ' + ( this.selectedvalue ) );  
    

    }


   
   

    @wire(getPicklistValuesByRecordType,{ recordTypeId:'0122w000001RwA4AAK', 

          objectApiName:CONTACT_OBJECT  })statusPicklist;
          

  contactHandleChange(event) {
      console.log(event.target.label);
      console.log(event.target.value);        
      if(event.target.label=='Orign'){
          this.Orign = event.detail.value;
      }
       
      
      if(event.target.label=='Status'){
          this.status = event.detail.value;
      }

      if(event.target.label=='Priority'){
          this.priority = event.detail.value;
      }
                 
  }

  createLookupContactAction(){
      console.log(this.selectedAccountId);
      const fields = {};
      fields[STATUS.fieldApiName] = this.status;
      fields[ORIGN.fieldApiName] = this.Orign;
      fields[PRIORITY.fieldApiName] = this.priority;
      
      
    
      const recordInput = { apiName: CASE_OBJ.objectApiName, fields };
      createRecord(recordInput)
          .then(contactobj=> {
              this.caserecordId = contactobj.id;
              this.fields={};
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Contact created successfully..!',
                      variant: 'success',
                  }),
              );
             
              


          })
          .catch(error => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Error creating record',
                      message: error.body.message,
                      variant: 'error',
                  }),
              );
          });
  } 

}