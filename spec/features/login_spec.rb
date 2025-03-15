# spec/features/login_spec.rb

require './spec/spec_helper'

RSpec.feature "User Login", type: :feature do
  let(:login_url) { "https://ecommerce-playground.lambdatest.io/index.php?route=account/login" }
  let(:valid_username) { "testemail1@gmail.com" }
  let(:valid_password) { "LambdaTest123" }
  let(:invalid_username) { "wrong@gmail.com" }
  let(:invalid_password) { "wrongpass" }

  before(:each) do
    visit login_url
  end

  scenario "Login page loads with login link present" do
    expect(page).to have_text("Returning Customer")
  end

  scenario "Successful login with correct credentials" do
    fill_in "input-email", with: valid_username
    fill_in "input-password", with: valid_password
    click_button "Login"

    expect(page).to have_text("My Account")
    expect(page).to have_text("My Affiliate Account")
  end

  scenario "Failed login with incorrect credentials" do
    fill_in "input-email", with: invalid_username
    fill_in "input-password", with: invalid_password
    click_button "Login"

    expect(page).to have_text("Warning: No match for E-Mail Address and/or Password.")
  end

  scenario "Successful login and logout" do
    fill_in "input-email", with: valid_username
    fill_in "input-password", with: valid_password
    click_button "Login"

    expect(page).to have_text("My Account")

    click_link "Logout"
    expect(page).to have_text("Account Logout")
  end
end