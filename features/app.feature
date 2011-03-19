Feature: List of beers
	In order to decide which items that shoulde be shown on the slides
	As a user
	I should be able to mark those items which should be displayed

	@items
	Scenario: Show list of items
		Given I am on the home page
		Then I should see "test1"
		And I should see "10kr"
