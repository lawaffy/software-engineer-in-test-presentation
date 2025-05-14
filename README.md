# Testing Strategy for Motability Vehicle Application Flow

## Overview

This repository contains the test scenarios for automating the testing of the **Motability Vehicle Application Flow**. It focuses on validating the application process, ensuring that eligibility checks are correctly performed, and verifying that API requests and responses are handled as expected.

The primary focus areas are:

1. **Form Validation**: Ensuring that the form inputs are correctly validated (e.g., data types, field limitations).
2. **API Requests**: Verifying that the API request is formed correctly and no malformed requests are sent.
3. **Eligibility Checks via DVLA API**: Ensuring that eligibility checks, including driver endorsements and disqualifications, are correctly handled by the system.

## Features

The tests in this repository cover various parts of the Motability application flow:

1. **Initial Form Application**:

   - Form validation (data types and limitations).
   - Allowing the addition of up to 3 drivers.
   - Vehicle and adaptation selection.
   - Form submission.

2. **API Request**:

   - Verifying correct POST request formation with properly structured JSON.
   - Handling error states when the API call fails.

3. **DVLA API Response & Eligibility Checks**:
   - Handling of DVLA API response, including checking eligibility based on the rules for driver endorsements, disqualifications, and full licenses.

## Testing Approach

The tests are divided into **integration tests** and **end-to-end tests**:

- **Integration Tests** focus on API request formations, success and response handling.
- **End-to-End Tests** simulate the full user journey, from form submission to receiving and processing the eligibility check results.

### File Structure

The tests are defined using **Gherkin syntax** to describe the expected behavior of the system:

- **Feature Files**: Contains the various test cases using Gherkin's Given-When-Then structure.
  - `form-validation.feature`: Tests for validating form inputs and submissions.
  - `api-request.feature`: Tests for verifying the API request and error handling.
  - `dvla-response.feature`: Tests for validating eligibility checks based on the DVLA API response.

## Getting Started

- A test runner like **Cucumber** (or any compatible Gherkin test runner) installed.
