@cli
Feature:
  Assuming there is BrowserCMS project that is currently running 3.3.x
  the upgrade script should handle generating, and/or manipulating files to make upgrading simple

  Background:
    Given I am working on a BrowserCMS v3.3.x project named "petstore"

  Scenario: Upgrade Project
    When I run `bcms upgrade`
    Then Gemfile should have the correct version of BrowserCMS
    And it should comment out Rails in the Gemfile
    And it should run bundle install
    And it should copy all the migrations into the project
    And it should add the seed data to the project
    And it prompt the user to update Rails

  Scenario: Projects with Content Block
    Given the project has a "turtle" block
    When I run `bcms upgrade`
    Then I should have a migration for updating the "turtle" versions table

  Scenario: Projects with Content Blocks and Models
    Basic Rails models should not be be included in the list of models getting an upgrade.

    Given the project has a "turtle" block
    And the project has a "category" model
    When I run `bcms upgrade`
    Then I should have a migration for updating the "turtle" versions table

  Scenario: Updates version table
    Given the project has a "turtle" block
    When I run `bcms upgrade`
    When I run `rake db:migrate`
    Then the output should contain "UpdateVersionIdColumns: migrated"






