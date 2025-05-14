Feature: Initial Form Application

  As a dealer submitting a customer’s vehicle application,
  I want to ensure the form handles data types, validations, and submissions correctly
  So that I can submit a valid application to the system

  # ===================
  # Happy Path Tests
  # ===================

  @e2e-testing

  Scenario: User enters valid form data and submits the application
    Given the user enters valid customer details (first name, last name, etc.)
    And the user adds 2 additional drivers with valid details
    And the user selects a valid vehicle and adaptations
    And the user selects a valid estimated delivery date
    And the user confirms the communication preferences
    When the user submits the application
    Then the system should submit the application successfully
    And the application should be saved and processed by the system

  # ===================
  # Negative Tests
  # ===================

  @e2e-testing

  Scenario: User adds more than 3 drivers
    Given the user adds 4 drivers to the application
    When the user attempts to submit the form
    Then the system should show an error message: "You can only add up to 3 drivers"

  Scenario: User fails to add required details
    Given the user leaves the required fields empty (e.g., first name, last name, vehicle details)
    When the user attempts to submit the application
    Then the system should show error messages for the missing required fields

  Scenario: DWP consent is not given
    Given the user leaves the DWP consent checkbox unchecked
    When the user submits the form
    Then the system should show "Consent must be given to continue"

  Scenario: No communication preference selected
    Given the user skips the communication preferences
    When the user submits the form
    Then the system should show "Please select at least one contact method"

  # ===================
  # Edge Cases
  # ===================

  @e2e-testing

  Scenario: User adds the same driver more than once
    Given the user adds a driver with the same name and license number as an existing driver
    When the user submits the form
    Then the system should show an error: "Duplicate drivers are not allowed"

  Scenario: User adds a driver with incomplete details
    Given the user adds an additional driver
    And only enters the driver's first name but not the license number
    When the user submits the form
    Then the system should show an error: "Please complete all driver details"

