### Ruby rSpec Capybara tutorial

This is a simple tutorial to show how to use rSpec and Capybara to test a simple web application.

### Prerequisites
- Ruby installation
- Firefox browser
- When running on cloud grid (Obtain username and access key from lambdaTest)

### Installation
- Clone the repository
- Run `bundle install` to install the required gems
- Run `rspec` to run the tests

### Running the tests
- Run `rspec` to run the tests

### Running the tests on cloud grid and In parallel
1. Set the environment variables `LT_USERNAME` and `LT_ACCESS_KEY` with your username and access key. Also set `TEST_ENV_NUMBER` to the job number.
  (You could set these variables in the terminal or create a `.env` file)
2. Run `bundle exec parallel_test spec/features -n 2 --type rspec ` to run the tests on cloud grid using 2 parallel jobs.
  (You could choose the number of jobs to run by changing this value)