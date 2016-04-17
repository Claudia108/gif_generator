require 'test_helper'

class UserFavoritesGifsTest < ActionDispatch::IntegrationTest
  test "user can view all gifs sorted by category" do
    create_categories
    create_gifs
    login_user

    # gif1 = "http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif"
    # gif2 = "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif"
    # category = "snow"

    assert_equal gifs_path, current_path
    assert page.has_content?("Hello, Leon!")

    assert page.has_content?("snow")
    assert page.has_css?("img[src*='http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif']")
    assert page.has_css?("img[src*='https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif']")
  end

  test "user can favorite gifs" do
    create_categories
    create_gifs
    login_user

    click_link "Favorite Your Gifs"

    assert_equal new_favorite_path, current_path
    assert page.has_content?("snow")
    assert page.has_css?("img[src*='http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif']")
    assert page.has_css?("img[src*='https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif']")

    page.check("snow1")

    click_button "Favorite Gifs"

    assert_equal favorites_path, current_path
    assert page.has_content?("snow")
    assert page.has_css?("img[src*='http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif']")
  end

  def login_user
    User.create(username: "Leon",
                       password: "password")

    visit root_path
    fill_in "session[username]", with: "Leon"
    fill_in "session[password]", with: "password"
    click_button "Login"
  end

  def create_categories
    @snow = Category.create(name: "snow")
  end

  def create_gifs
    @gif1 = Gif.create(image_path: "http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif", category_id: @snow.id)
    @gif2 = Gif.create(image_path: "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif", category_id: @snow.id)
  end
end
