Feature: API Request by POST

  As a dealer submitting vehicle eligibility requests,
  I want to ensure the system formats and sends the correct API request
  So that the eligibility data can be processed correctly by the system

  # Integration Testing

  Scenario: Inputs are transformed into the correct JSON format by POST
    Given the user has entered valid form data
    When the user submits the application
    Then the system should send a POST request to "/api/v2/applications" with the correct JSON body
    And the JSON should include customer details, drivers, vehicle adaptations, etc.
  
  Scenario: UI displays loading or error state if API call fails
    Given the user submits the application
    When the API call fails (e.g., due to network issues)
    Then the UI should display an error message "Unable to submit application. Please try again later."
    And the user should see a loading spinner while the request is being processed

  Scenario: System retries API call on timeout or failure
    Given the DVLA API times out after the first attempt
    When the system attempts to contact the DVLA API
    Then the system should retry the request up to 3 times
    And show "Please try again later" if the retries fail

  Scenario: API request handles network error gracefully
    Given the DVLA API returns a network error
    When the user submits the form
    Then the system should show "Unable to reach the DVLA API, please try again later"