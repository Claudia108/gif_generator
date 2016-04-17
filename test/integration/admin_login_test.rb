require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  test "admin can login and view the categories index page" do
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path

    assert page.has_content?("All Categories")
  end

  test "default user cannot login and view the categories index page" do
    user = User.create(username: "user",
                       password: "password",
                       role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_categories_path

    refute page.has_content?("All Categories")
    # assert_equal "/public/404", current_path
    assert page.has_content?("The page you were looking for doesn't exist (404)")
  end

end
