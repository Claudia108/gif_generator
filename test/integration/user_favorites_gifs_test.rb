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

  test "user can un-favorite gifs" do
    create_categories
    create_gifs
    login_user

    visit new_favorite_path
    page.check("snow1")
    # page.check("puppy1")
    click_button "Favorite Gifs"


    # save_and_open_page
    click_on "1-delete"

    assert_equal favorites_path, current_path
    refute page.has_content?("snow")
    refute page.has_css?("img[src*='http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif']")


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
    @puppies = Category.create(name: "puppies")
  end

  def create_gifs
  Gif.create(image_path: "http://media1.giphy.com/media/aCpvwi2tuFQUE/200w.gif", category_id: @snow.id)
    @snow2 = Gif.create(image_path: "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif", category_id: @snow.id)

    @puppy1 = Gif.create(image_path: "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif", category_id: @puppies.id)
    @puppy2 = Gif.create(image_path: "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif", category_id: @puppies.id)
    @puppy3 = Gif.create(image_path: "https://media4.giphy.com/media/sTUe8s1481gY0/200w.gif", category_id: @puppies.id)

  end
end
