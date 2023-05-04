trigger CaseTrigger on Case (before insert) {
    if(Trigger.isBefore && trigger.isInsert)
    {
        CaseHandler.caseAssign(Trigger.New);
    }

}