import { LightningElement ,api,track,wire} from 'lwc';
import getOrder from '@salesforce/apex/OrderHandler.getOrder';

export default class CreateCaseDealerChildComp extends LightningElement {
    @api accidfromparent ;
    @track ordervalue ='';
    @track optionsOrder=[];

    get options(){
        return this.optionsOrder ;
    }

   /*@wire(getOrder,{accountid :'$accidfromparent'})ord({data,error}){
           if(data){
            let arr =[];
            console.log('In Order ')
            for(var i=0 ; i< data.length ; i++){
                arr.push ({label : data[i].OrderNumber , value : data[i].Name})
            }
            this.optionsOrder =arr ;
            console.log( 'arr : '+arr);

           }
   } */






connectedCallback(){

 // console.log('Id '+ accidfromparent);
    getOrder({accountid :'$accidfromparent' }).then(response => {
        let arr =[];
        console.log('In Order ')
        for(var i=0 ; i< response.length ; i++){
            arr.push ({label : response[i].OrderNumber , value : response[i].Name})
        }
        this.optionsOrder =arr ;
        console.log( 'arr : '+arr);
    })
    } 
    
  
    
    
    handleOrderChange(event){
        this.ordervalue = event.detail.value;
    }
    
}