require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  test "registered user can login" do
    login_user

    assert_equal gifs_path, current_path
    assert page.has_content?("Hello, Leon!")
  end

  test "user cannot login with invalid username" do
    user = User.create(username: "Leon",
                       password: "password")

    visit root_path
    fill_in "session[username]", with: "Leon"
    fill_in "session[password]", with: "notmypassword"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid. Please try again.")
    assert page.has_button?("Login")
  end

  test "user cannot login with invalid password" do
    user = User.create(username: "Leon",
                       password: "password")
    visit root_path
    fill_in "session[username]", with: "Leonna"
    fill_in "session[password]", with: "password"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid. Please try again.")
    assert page.has_button?("Login")
  end

  test "registered user can logout" do
    login_user

    assert page.has_content?("Hello, Leon!")
    click_link "Logout"

    refute page.has_content?("Hello, Leon!")
    assert page.has_button?("Login")
    # assert page.has_content?("Goodbye")
    assert_equal root_path, current_path
  end


  def login_user
    User.create(username: "Leon",
                       password: "password")

    visit root_path
    fill_in "session[username]", with: "Leon"
    fill_in "session[password]", with: "password"
    click_button "Login"
  end

end
