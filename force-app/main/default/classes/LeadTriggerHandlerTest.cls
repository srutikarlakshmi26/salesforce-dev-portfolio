@istest
public class LeadTriggerHandlerTest {
    
    @istest
    static void testHighPriorityLead() {
        
        //1. Create a test lead with Annual Revenue >= 10,000,000
        Lead testLead = new Lead(
            FirstName = 'Test',
        LastName = 'Lead',
        Company = 'Test Company',
        AnnualRevenue = 15000000,
        Industry = 'Technology'
            );
        
        //2. Perform DML Operation to insert the lead
        Test.startTest();
        insert testLead;
        Test.stopTest();
        
        //3. Retrieve the lead from the database to check the priority
        Lead insertedLead = [SELECT Lead_Priority__c FROM Lead WHERE Id = :testLead.Id];
        
        //4. Assert that the priority is set to 'High'
        System.assertEquals('High', insertedLead.Lead_Priority__c, 'The lead priority should be High for leads with Annual Revenue >= 10,000,000.');
    }
    @istest
    static void testPriorityHigh1(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'High',
        LastName = 'Lead1',
        Company = 'Test Company',
        AnnualRevenue = 10000000,
        Industry = 'Retail'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'High'
        System.assertEquals('High', priority, 'The lead priority should be High');
    }
    
    @istest
    static void testPriorityHigh2(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'High',
        LastName = 'Lead3',
        Company = 'Test Company',
        AnnualRevenue = 20000000,
        Industry = 'Technology'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'High'
        System.assertEquals('High', priority, 'The lead priority should be High');
    }
    
    @istest
    static void testPriorityMedium(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'Medium',
        LastName = 'Lead1',
        Company = 'Test Company',
        AnnualRevenue = 50000,
        Industry = 'Finance'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'Medium'
        System.assertEquals('Medium', priority, 'The lead priority should be Medium for leads in the Finance industry.');
    }
    
    @istest
    static void testPriorityMedium1(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'High',
        LastName = 'Lead2',
        Company = 'Test Company',
        AnnualRevenue = 1000000,
        Industry = 'Retail'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'Medium'
        System.assertEquals('Medium', priority, 'The lead priority should be Medium');
    }
    
    @istest
    static void testPriorityMedium2(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'Medium',
        LastName = 'Lead3',
        Company = 'Test Company',
        AnnualRevenue = 50000,
        Industry = 'Technology'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'Medium'
        System.assertEquals('Medium', priority, 'The lead priority should be Medium');
    }
    
    @istest
    static void testPriorityLow(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'Low',
        LastName = 'Lead1',
        Company = 'Test Company',
        Industry = 'Retail'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'Low'
        System.assertEquals('Low', priority, 'The lead priority should be Low.');
    }
    
    @istest
    static void testPriorityLow1(){
        //1. Create in-memory test lead with finance and low revenue
        Lead testLead = new Lead(
            FirstName = 'Low',
        LastName = 'Lead2',
        Company = 'Test Company',
        AnnualRevenue = 0,
        Industry = 'Retail'
            );
        
        //2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        //3. Assert that the priority is set to 'Medium'
        System.assertEquals('Low', priority, 'The lead priority should be Low.');
    }
    
    @istest
    static void testPriorityLow2() {
        // 1. Create in-memory test lead just below the 1M threshold with non-strategic industry
        Lead testLead = new Lead(
            FirstName = 'Low',
        LastName = 'Boundary',
        Company = 'Test Company',
        AnnualRevenue = 999999,
        Industry = 'Retail'
            );
        
        // 2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        // 3. Assert that the priority is set to 'Low'
        System.assertEquals('Low', priority, 'The lead priority should be Low just below 1M revenue.');
    }
    
}