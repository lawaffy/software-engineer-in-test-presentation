Feature: DVLA API Response and Eligibility Checks

  As a dealer receiving eligibility data from the DVLA API,
  I want to ensure the system processes the response correctly and applies business rules
  So that I can confirm the eligibility of the vehicle and driver(s)

  # ===================
  # Happy Path Tests
  # ===================

  @integration-testing

  Scenario: DVLA API response received and parsed correctly
    Given the system submits driver details to the DVLA API
    When the system receives a response with valid eligibility data
    Then the system will process the response and apply business rules correctly
    And the eligibility status will be displayed to the user

  @e2e-testing

  Scenario: Vehicle meets eligibility criteria
    Given the DVLA API returns a response with "eligible: true"
    When the system processes the response
    Then the system will display "Vehicle is eligible"
    And proceed to the next step in the application

  Scenario: At least one driver must have a full license
    Given the DVLA API returns a response with 'license: true'
    When the system processes the response
    Then the systen will display 'Driver has license'
    And proceed to the next step in the application


  # ===================
  # Negative Tests
  # ===================

  @integration-testing

  Scenario: API response returns an error status
    Given the DVLA API returns a 500 error response
    When the system processes the response
    Then the system will display "There was an error processing the vehicle details"
    And prompt the user to try again later

  Scenario: API response is empty or invalid
    Given the DVLA API returns an empty or invalid response
    When the system processes the response
    Then the system will display "Invalid response received from the DVLA API"
    And prompt the user to check the registration number and try again

  @e2e-testing

  Scenario: Error handling for DVLA response - Driver Disqualified
    Given the DVLA API returns a response indicating the driver is "disqualified"
    When the system processes the response
    Then the system will display the error "Driver is disqualified and cannot be included"

  Scenario: Mock test DVLA response to check business rule - Driver with Automatic Licence
    Given the DVLA API returns a response with driver having "automatic" licence type
    And the selected vehicle has a "manual" transmission
    When the system processes the response
    Then the system will display the error "Driver with automatic licence cannot drive a manual vehicle"

   Scenario: Endorsement business rule - Driver with 2 endorsements in category G within the last 4 years
    Given the DVLA API returns a response with a driver having "2" endorsements from category G in the last 4 years
    When the system processes the response
    And the system will display the error "Driver has too many endorsements in category G in the last 4 years"
    Then the vehicle will not be eligible for that driver

  Scenario: Endorsement business rule - Driver with 1 endorsement in category F within the last 4 years
    Given the DVLA API returns a response with a driver having "1" endorsement from category F in the last 4 years
    When the system processes the response
    And the system will display the error "Driver has an endorsement from category F in the last 4 years"
    Then the vehicle will not be eligible for that driver

  Scenario: User-friendly messaging for failed eligibility check
    Given the DVLA API returns a response with "eligible: false" and a reason for ineligibility
    When the system processes the response
    And the system will display a user-friendly message explaining the ineligibility reason (e.g., "Driver has too many endorsements from categories G, H, and I")
    Then the form will be blocked from submission

  # ===================
  # Edge Cases
  # ===================

  @e2e-testing

  Scenario: Edge case for endorsements - Driver with multiple endorsements in last 4 years
    Given the DVLA API returns a response with a driver having "4" endorsements in the last 4 years from categories G, H, and I
    When the system processes the response
    Then the system will display the error "Driver has too many endorsements in the last 4 years"

  Scenario: Driver with no endorsements in the last 4 years
    Given the DVLA API returns a response with a driver having "0" endorsements in the last 4 years
    When the system processes the response
    Then the system will display "Driver is eligible"

  Scenario: Driver with multiple license types across vehicle categories
    Given the DVLA API returns a response with a driver holding both "automatic" and "manual" license types across various vehicle categories
    And the driver is attempting to drive a "manual" transmission vehicle
    When the system processes the response
    Then the system will display "Driver's license types are ambiguous, manual vehicle eligibility unclear"

    # Additional Tests to consider around Business Rules:

    # Scenario where more than one driver is linked — if eligibility depends on all drivers meeting rules
    # Endorsements older than 4 years don’t affect eligibility — test boundary dates?
    # If a license is expired or temporarily suspended, check impact