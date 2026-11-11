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
            FirstName = 'Medium',
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
        
        //3. Assert that the priority is set to 'Low'
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
    
    @istest
    static void testPriorityLow3() {
        // 1. Create in-memory test lead just below the 1M threshold with non-strategic industry
        Lead testLead = new Lead(
            FirstName = 'Low',
        LastName = 'Lead3',
        Company = 'Test Company'
            );
        
        // 2. Call Handler method directly and capture the result
        String priority = LeadTriggerHandler.determinePriority(testLead);
        
        // 3. Assert that the priority is set to 'Low'
        System.assertEquals('Low', priority, 'The lead priority should be Low when Annual Revenue is null and Industry is not strategic.');
    }
    
    @isTest
    static void testUpdateLeadPriorityToHigh() {
        // 1. Create and insert a lead that starts as Low priority
        Lead testLead = new Lead(
            FirstName = 'Update',
        LastName = 'Test1',
        Company = 'Startup Corp',
        AnnualRevenue = 50000,
        Industry = 'Retail'
            );
        insert testLead;
        
        // Verify it started as Low
        Lead insertedLead = [SELECT Lead_Priority__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('Low', insertedLead.Lead_Priority__c, 'Initial priority should be Low.');
        
        // 2. Modify the lead's annual revenue to cross the High threshold
        testLead.AnnualRevenue = 15000000;
        
        // 3. Perform the update DML operation (fires before update trigger)
        Test.startTest();
        update testLead;
        Test.stopTest();
        
        // 4. Query back and assert the priority updated to High
        Lead updatedLead = [SELECT Lead_Priority__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('High', updatedLead.Lead_Priority__c, 'Priority should update to High when revenue increases.');
    }
    
    @isTest
    static void testUpdateLeadPriorityToMedium() {
        // 1. Create and insert a lead that starts as High priority
        Lead testLead = new Lead(
            FirstName = 'Update',
        LastName = 'Test2',
        Company = 'Enterprise Corp',
        AnnualRevenue = 20000000,
        Industry = 'Retail'
            );
        insert testLead;
        
        // Verify it started as High
        Lead insertedLead = [SELECT Lead_Priority__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('High', insertedLead.Lead_Priority__c, 'Initial priority should be High.');
        
        // 2. drop revenue low, but change industry to Finance
        testLead.AnnualRevenue = 100000;
        testLead.Industry = 'Finance';
        
        // 3. Perform the update DML operation
        Test.startTest();
        update testLead;
        Test.stopTest();
        
        // 4. assert the priority updated to Medium
        Lead updatedLead = [SELECT Lead_Priority__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('Medium', updatedLead.Lead_Priority__c, 'Priority should update to Medium based on industry change.');
    }
    
    //BULK TEST CASES
    
    @isTest
    static void testBulkLeadTrigger() {
        // 1. Create a list to hold our test leads and a map to track expected priorities
        List<Lead> bulkLeads = new List<Lead>();
        Map<String, String> expectedPriorities = new Map<String, String>();
        
        // 2. Generate 200 test leads and explicitly map expected outcomes based on known loop criteria
        for (Integer i = 0; i < 200; i++) {
            Decimal rev = (i < 50) ? 15000000 : 50000; // First 50 high revenue, rest low
            String ind = (Math.mod(i, 2) == 0) ? 'Technology' : 'Retail'; // Alternating industries
            String lastName = 'Test' + i;
            
            // Determine expected priority explicitly based on rules
            String expectedPriority;
            if (i < 50) {
                expectedPriority = 'High';
            } else if (Math.mod(i, 2) == 0) {
                expectedPriority = 'Medium';
            } else {
                expectedPriority = 'Low';
            }
            
            expectedPriorities.put(lastName, expectedPriority);
            
            bulkLeads.add(new Lead(
                FirstName = 'Bulk',
            LastName = lastName,
            Company = 'Company ' + i,
            AnnualRevenue = rev,
            Industry = ind
                ));
        }
        
        // 3. Perform bulk DML operation to insert the leads
        Test.startTest();
        insert bulkLeads;
        Test.stopTest();
        
        // 4. Query back the inserted leads including LastName
        List<Lead> insertedLeads = [SELECT Id, LastName, Lead_Priority__c FROM Lead WHERE Id IN :bulkLeads];
        
        // 5. Assert the query returned exactly 200 records
        System.assertEquals(200, insertedLeads.size(), 'The query should have returned exactly 200 inserted leads.');
        
        // 6. Assert each lead got the exact expected value
        for (Lead l : insertedLeads) {
            String expected = expectedPriorities.get(l.LastName);
            System.assertEquals(expected, l.Lead_Priority__c, 'Priority mismatch for lead: ' + l.LastName);
        }
    }