import { LightningElement , wire } from 'lwc';
import getProductList from '@salesforce/apex/getProduct.getProductList'

export default class CommunityLeadRecordsComp extends LightningElement {
    @wire(getProductList)rupom;
}