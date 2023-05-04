import { LightningElement ,wire} from 'lwc';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class ComboboxComp extends LightningElement {

    options = [];
    selectedValue;

    @wire( getObjectInfo, { objectApiName: ACCOUNT_OBJECT } )
    objectInfo;

    @wire( getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD } )
    wiredData( { error, data } ) {

        console.log( 'Inside Get Picklist Values' );

        if ( data ) {
                            
            console.log( 'Data received from Picklist Field ' + JSON.stringify( data.values ) );
            this.options = data.values.map( objPL => {
                return {
                    label: `${objPL.label}`,
                    value: `${objPL.value}`
                };
            });
            console.log( 'Options are ' + JSON.stringify( this.options ) );

        } else if ( error ) {

            console.error( JSON.stringify( error ) );

        }

    }

    handlePicklistChange( event ) {
        console.log('here is Console 1') ;
        console.log( 'New Value selected is ' + JSON.stringify( event.detail.value ) );   

    }
}


