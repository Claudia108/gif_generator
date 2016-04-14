require 'test_helper'

class UserVisitsRootPageTest < ActionDispatch::IntegrationTest
  test "user can visit root page" do
    visit root_path

    assert page.has_content?("Welcome!")
  end
end
