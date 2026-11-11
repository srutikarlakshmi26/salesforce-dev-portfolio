public with sharing class LeadTriggerHandler {
    
    public void evaluatePriority(List<Lead> newLeads) {
        for (Lead l: newLeads) {
            //Calls determinePriority method for each lead
            l.Lead_Priority__c = determinePriority(l);
        }
    }
    
    public static String determinePriority(Lead l) {
        //Evaluate lead given by evaluatePriority based on Priority Rule
        
        if(l.AnnualRevenue != null && l.AnnualRevenue >= 10000000){
            return 'High';
        }
        else if ((l.AnnualRevenue != null && l.AnnualRevenue >= 1000000) || l.Industry == 'Technology' || l.Industry == 'Finance'){
            return 'Medium';
        }
        return 'Low';
    }
}