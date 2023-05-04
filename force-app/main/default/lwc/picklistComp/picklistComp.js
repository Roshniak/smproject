import { LightningElement ,track,wire,api } from 'lwc';
import { getPicklistValuesByRecordType, getObjectInfo,getPicklistValues} from 'lightning/uiObjectInfoApi';
import CASE__OBJ from '@salesforce/schema/Case';
import STATUS from '@salesforce/schema/Case.Status';
import ORIGIN from '@salesforce/schema/Case.Origin';
import findRecordTypeId from '@salesforce/apex/recordTypeClass.findRecordTypeId';

export default class PicklistComp extends LightningElement {
    @track statusOptions;
    @track value;
    @api objectApiName;
    @track objectInfo;
    @track recdTypeid;
    @track selectedrecordType;
    @api rectypename;
    
    
    
    
    @track pickListvaluesByRecordType =[];
    @track values;
    @track error;
    @track statusPickListValues;
    @track OriginPickListValues;
    @track selectedAccountId;
 

    
    @wire(getPicklistValuesByRecordType ,{
        recordTypeId :'0122w000001RwA4AAK'  ,
        objectApiName :CASE__OBJ
    })wiredRecordtypesValues({data,error}){
        if(data){
            console.log('PickList values',data);
          this.pickListvaluesByRecordType =data.picklistFieldValues.Sub_Type__c.values ;
           this.error = undefined;

        }
    
    }

    handleChange(event){
        var chose =event.target.value;
        console.log(chose);
    }

   

    

    @wire(getObjectInfo, { objectApiName:  CASE__OBJ,})
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

    handleRecordType(event){
         this.selectedrecordType = event.target.value;
         
        console.log(event.target.value);
    }

   /*  @wire(findRecordTypeId ,{rectypename :'$this.selectedrecordType'})recdTypeidvalue({data,error}){
        if(data)
        {
            this.recdTypeid = data;
            this.error = undefined ;
        }
        if(error){

        }
    }  */


     //Picklist Values for Status field
     @wire(getPicklistValues ,{
        recordTypeId :'0122w000001RwA4AAK'  ,
    
        fieldApiName : STATUS
    })wiredStatusPickListValues ({data,error}){
        if(data)
        {
            this.statusPickListValues = data.values ;
            this.error = undefined ;
        }
        if(error){

        }
    }

    handleStatusChange(event){
        console.log(event.target.value);
    }

     //Picklist Values for ORIGIN field
     @wire(getPicklistValues ,{
        recordTypeId :'0122w000001RwA4AAK'  ,
    
        fieldApiName : ORIGIN
    })wiredOriginPickListValues ({data,error}){
        if(data)
        {
            this.OriginPickListValues = data.values ;
            this.error = undefined ;
        }
        if(error){

        }
    }

    handleOrignChange(event){
console.log(event.target.value);
    }

    myLookupHandle(event){
        console.log(event.detail);
        this.selectedAccountId = event.detail;
    }

}
   