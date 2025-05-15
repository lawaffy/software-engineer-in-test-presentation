Feature: API Request by POST

  As a dealer submitting vehicle eligibility requests,
  I want to ensure the system formats and sends the correct API request
  So that the eligibility data can be processed correctly by the system

  # ===================
  # Happy Path Tests
  # ===================

  @integration-testing

  Scenario: Inputs are transformed into the correct JSON format by POST
    Given the user has entered valid form data
    When the user submits the application
    Then the system will send a POST request to "/api/v2/applications" with the correct JSON body
    And the JSON will include customer details, drivers, vehicle adaptations, etc.
  
  # ===================
  # Negative Tests
  # ===================

  @integration-testing

  Scenario: UI displays loading or error state if API call fails
    Given the user submits the application
    When the API call fails (e.g., due to network issues)
    Then the user will see a loading spinner while the request is being processed
    And the UI will display an error message "Unable to submit application. Please try again later."

  Scenario: System retries API call on timeout or failure
    Given the DVLA API times out after the first attempt
    When the system attempts to contact the DVLA API
    Then the system will retry the request up to 3 times
    And show "Please try again later" if the retries fail

  Scenario: API request handles network error gracefully
    Given the dealer has input the user's application correctly
    And the application has been submitted
    And the request has been made to the DVLA API
    When there is a server error
    Then the UI will show "Unable to reach the DVLA API, please try again later"

  # form validation tests for not being able to add letters into phone number, etc could be built up too  

  # ===================
  # Edge Cases
  # ===================

  @integration-testing

  Scenario: User double-clicks submit and triggers multiple requests
    Given the dealer has input the user's application correctly
    When the application has been submitted
    Then the submit utton will be disabled
    And the dealer cannot submit the application a second time
