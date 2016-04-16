require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  test "admin can login and view the categories index page" do
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)
    ApplicationController.any_instance.stubs[:current_user].returns(admin)

    visit admin_categories_path

    assert page.has_content?("All Categories")
  end

end
