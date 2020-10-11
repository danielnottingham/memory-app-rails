Feature: Creating a new item
  User possibility
  Register in the system
  To be able to manage your tasks
  
  Scenario: Creating a new item
    Given I visit the new item page
    And I fill in Key with "telefone"
    And I fill in Value with "numero"
    And click on the "Add" button
    Then the item with key "telefone" exists
    And I should be sent to the page "/items"