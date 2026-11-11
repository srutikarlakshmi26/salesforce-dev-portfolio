List<Lead> leadsToInsert = new List<Lead>();

leadsToInsert.add(new Lead(
  FirstName = 'John',
  LastName = 'Doe',
  Company = 'Doe Enterprises',
  Email = 'john.doe@example.com',
  Phone = '123-456-7890'
));

leadsToInsert.add(new Lead(
  FirstName = 'Jane',
  LastName = 'Smith',
  Company = 'Smith Solutions',
  Email = 'jane.smith@example.com',
  Phone = '987-654-3210'
));

leadsToInsert.add(new Lead(
  FirstName = 'Alice',
  LastName = 'Johnson',
  Company = 'Johnson Innovations',
  Email = 'alice.johnson@example.com',
  Phone = '555-123-4567'
));

// Insert the leads
try {
  insert leadsToInsert;
  System.debug('Leads inserted successfully: ' + leadsToInsert);
} catch (DmlException e) {
  System.debug('Error inserting leads: ' + e.getMessage());
}