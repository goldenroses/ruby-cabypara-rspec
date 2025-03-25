# spec/features/search_spec.rb

require './spec/spec_helper'

RSpec.feature "User Login", type: :feature do
  let(:login_url) { "https://ecommerce-playground.lambdatest.io/index.php?route=account/login" }
  let(:valid_username) { "testemail1@gmail.com" }
  let(:valid_password) { "LambdaTest123" }

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

  scenario "Search for a product" do
    fill_in "search", with: "Phone"
    click_button "Search"

    expect(page).to have_text("Search - Phone")
  end
end