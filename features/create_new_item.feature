Feature: Creating a new item
  
  Scenario: Creating a new item
    Given I visit the url "/items/new"
    And The current url should be "/items/new"
    And I fill in field "#item_key" with "name"
    And I fill in field "#item_value" with "nottingham"
    And click on the "Add" button
    Then the item with key "name" exists
    And The current url should be "/items"