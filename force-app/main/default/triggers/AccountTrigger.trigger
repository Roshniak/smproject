trigger AccountTrigger on Account (before delete) {
 if(Trigger.isBefore && Trigger.isDelete)
 {
     AccountHandler.getAccount(trigger.old);
 }
}