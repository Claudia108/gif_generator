require 'test_helper'

class AdminCreatesCategoriesTest < ActionDispatch::IntegrationTest
  test "admin creates a catory" do
    admin_login

    click_link "New Category"
    assert_equal new_admin_category_path, current_path

    new_category = "kitten"
    fill_in "category[name]", with: new_category
    click_button "Create Category"

    assert_equal admin_category_path(Category.last.id), current_path
    assert page.has_content?("Your New Category")
    assert page.has_content?("kitten")
  end

  test "admin can delete categories" do
    Category.create(name: "kitten")
    admin_login

    click_link "Delete"

    refute page.has_content?("kitten")

  end

  def admin_login
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path
  end
end
