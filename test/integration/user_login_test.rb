require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  test "registered user can login" do
    user = User.create(username: "Leon", password: "password", role: 0)

    visit root_path

    fill_in "user_username", with: "Leon"
    fill_in "user_password", with: "password"
    click_button "Login"

    assert_equal gifs_path, current_path
    assert page.has_content?("Hello, Leon!")
  end



# As a user
# when I visit the root page
# and I click the login button
# and I enter my account information
# and I click the login button
# I will be greeted as loogin in visitor by name
# and I will see all my gifs

end
