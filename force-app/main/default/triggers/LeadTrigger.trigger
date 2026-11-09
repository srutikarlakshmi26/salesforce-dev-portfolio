trigger LeadTrigger on Lead (before insert, before update) {

  for (Lead l: Trigger.new){
    //Evaluate based on Priority Rule

    if(l.AnnualRevenue != null && l.AnnualRevenue >= 10000000){
      l.Lead_Priority__c = 'High';
    }
    else if ((l.AnnualRevenue != null && l.AnnualRevenue >= 1000000) ||
          l.Industry == 'Technology' || l.Industry == 'Finance'){
          l.Lead_Priority__c = 'Medium';
    }
    else {
    l.Lead_Priority__c = 'Low';
    }

    //Debug each individual lead evaluation
    System.debug('Lead Name: ' + l.Name + ', Annual Revenue: ' + l.AnnualRevenue + ', Industry: ' + l.Industry + ', Lead Priority: ' + l.Lead_Priority__c);
}
  
  System.debug(
    '\n========= LeadTrigger Execution Log ========='+
    '\nOperation Type: ' + Trigger.operationType +
    '\nNumber of records: ' + Trigger.size +
    '\n============================================'
  );
}