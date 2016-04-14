require 'test_helper'

class UserCreationTest < ActionDispatch::IntegrationTest
  test "user can create a user account" do
    visit root_path
    click_link "New User"

    assert_equal new_user_path, current_path

    fill_in "user_username", with: "Ronald"
    fill_in "user_password", with: "password"
    click_button "Create Account"

    assert_equal gifs_path, current_path
    assert page.has_content?("All Gifs")
  end

end
