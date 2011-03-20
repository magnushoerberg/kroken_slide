@items
Feature: Slideshow
	In order to display the assortment of item to a customer
	As a salesman
	I want to display the assortment on a slideshow

	Scenario: Show list of items
		Given I am on the home page
		Then I should see "test1"
		And I should see "10kr"

	@javascript
	Scenario: Select items to be displayed
		Given I am on the home page
		When I check "test1[display]"
		And I press "Starta bildspel"
		Then I should be on the slide show page
		And I should see "test1"
		And I should see "10kr"
