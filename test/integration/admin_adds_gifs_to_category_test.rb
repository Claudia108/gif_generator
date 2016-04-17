require 'test_helper'

class AdminAddsGifsToCategoryTest < ActionDispatch::IntegrationTest
  test "admin can select gifs" do
    admin_login

    visit new_admin_category_path
    category = "kittens"
    fill_in "category[name]", with: category
    click_button "Search"

    assert_equal new_admin_category_gif_path(Category.last.id), current_path
    page.check("1")
    page.check("14")
    page.check("5")

    click_button "Generate Gifs"

    assert page.has_content?("kittens")
    assert_equal admin_category_path(Category.find_by(name: "kittens").id), current_path
    url = Gif.last.image_path
    assert page.has_css?("img[src*='#{url}']")
  end

  def admin_login
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path
  end
end
