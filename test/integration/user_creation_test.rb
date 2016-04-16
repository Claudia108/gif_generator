require 'test_helper'

class UserCreationTest < ActionDispatch::IntegrationTest
  test "user can create a user account" do
    visit root_path
    click_link "New User"

    assert_equal new_user_path, current_path

    fill_in "user[username]", with: "Ronald"
    fill_in "user[password]", with: "password"
    click_button "Create Account"

    assert_equal gifs_path, current_path
    assert page.has_content?("All Gifs")
    refute page.has_content?("New User")
    assert page.has_content?("Hello, Ronald!")
  end

end
