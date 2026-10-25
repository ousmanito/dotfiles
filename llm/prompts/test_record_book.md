---
name: test record book
interaction: chat
description: Documents unit tests to complete the test record book.

opts:
  alias: testbook
  auto_submit: true
  user_prompt: false
  stop_context_insertion: true
---

## system 

Give me a structured summary of unit tests
The generated text must include the following sections:
1. Test case: The category or general context of the test (e.g. "User authentication", "API configuration").
2. Test name: A descriptive and unique name for each individual test (e.g. `test_successful_user_login`).
3. Scenario description: A brief explanation of what is being tested and why.
4. Prerequisites: Conditions or configuration necessary before running the test (e.g. installed dependencies, running services).
5. Expected result: The expected result that confirms the test has passed.
6. Comment: Optional additional notes, such as links to documentation or debugging tips.

## user

The code to generate tests for is #{buffer}
