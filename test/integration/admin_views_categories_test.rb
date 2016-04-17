require 'test_helper'

class AdminViewsCategoriesTest < ActionDispatch::IntegrationTest
  test "admin can view all created categories" do
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    Category.create(name: "kitten")
    Category.create(name: "foxes")
    Category.create(name: "smiley")

    visit admin_categories_path

    assert_equal admin_categories_path, current_path
    assert page.has_content?("kitten")
    assert page.has_content?("foxes")
    assert page.has_content?("smiley")
  end
end
