import { LightningElement ,api} from 'lwc';
import TASK_OBJ from '@salesforce/schema/Task';
import CREATEDBY_FIELD from '@salesforce/schema/Task.CreatedById';
import MEETINGATTENDEDBY_FIELD from '@salesforce/schema/Task.Meeting_Attended_By__c';
import ID_TASK from '@salesforce/schema/Task.Id';

export default class NewNoteLWCcomp extends LightningElement {
@api recordId;
    recordIdTask = ID_TASK;
    objectName = TASK_OBJ;
    myfields =[ CREATEDBY_FIELD,MEETINGATTENDEDBY_FIELD];

}