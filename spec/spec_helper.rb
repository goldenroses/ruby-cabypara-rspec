# spec/spec_helper.rb
require 'capybara/rspec'
require 'selenium-webdriver'

# Capybara.configure do |config|
#   config.default_driver = :selenium_firefox # or your preferred driver
#   config.default_max_wait_time = 5 # adjust as needed
# end

# # Configure Selenium to use Firefox
# Capybara.register_driver :selenium_firefox do |app|
#   Capybara::Selenium::Driver.new(app, browser: :firefox)
# end

# RSpec.configure do |config|
#   config.include Capybara::DSL

#   config.before(:suite) do
#     # Any setup needed before all tests
#   end

#   config.after(:suite) do
#     # Any cleanup needed after all tests
#   end
# end

Capybara.configure do |config|
  config.default_driver = :selenium_remote
  config.default_max_wait_time = 30 # Increase wait time for cloud grid
  config.app_host = "https://ecommerce-playground.lambdatest.io" # Optional base URL
end

# Register the remote driver for LambdaTest
Capybara.register_driver :selenium_remote do |app|
  thread_number = ENV['TEST_ENV_NUMBER'].to_i.zero? ? 1 : ENV['TEST_ENV_NUMBER'].to_i

  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['browserName'] = 'Firefox'
  capabilities['browserVersion'] = 'latest'
  capabilities['LT:Options'] = {
    'platformName' => 'Windows 11',
    'resolution' => '1920x1080',
    'build' => 'RSpec Login Tests',
    'name' => "User Login Feature #{thread_number}",
    'username' => LT_USERNAME,
    'accessKey' => LT_ACCESS_KEY,
    'visual' => true,
    'video' => true,
    'network' => true
  }

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "https://#{LT_USERNAME}:#{LT_ACCESS_KEY}@#{GRID_URL}",
    capabilities: capabilities # Use only :options, no :capabilities
  )
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:suite) do
    puts "Running on LambdaTest grid with driver: #{Capybara.current_driver}"
  end

  config.after(:suite) do
    # Ensure the session closes properly
    Capybara.current_session.driver.quit
  end
end

