trigger LeadTrigger on Lead (before insert, before update) {

  //1. Create an instance of your handler class
  LeadTriggerHandler handler = new LeadTriggerHandler();

  //2. Check the context(is it before insert or update?)
  if(trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate)){
    //3. Call you handler method and pass Trigger.New
    handler.evaluatePriority(Trigger.new);
  }
}