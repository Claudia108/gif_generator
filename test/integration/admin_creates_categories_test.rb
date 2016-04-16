require 'test_helper'

class AdminCreatesCategoriesTest < ActionDispatch::IntegrationTest
  test "admin creates a catory" do
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path
    click_link "New Category"
    assert_equal new_admin_category_path, current_path

    new_category = "kitten"
    fill_in "category[name]", with: new_category
    click_button "Create Category"

    assert_equal admin_category_path(Category.last.id), current_path
    assert page.has_content?("Your New Category")
    assert page.has_content?("kitten")
  end
end
# As an admin
# if I log in
# and I am on the categories page
# and I enter a search term
# and I click on search
# I will see a page that includes a link to categories page

#
