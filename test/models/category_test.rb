require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "it creates a category" do
    category = Category.new(name: "kitten")

    assert category.valid?
    assert_equal "kitten", category.name
  end

  test "it cannot create a category with invalid name" do
    category = Category.new

    assert category.invalid?
  end

  test "it cannot create a category with the same name" do
    2.times { Category.create(name: "kitten") }

    result = Category.where(name: "kitten")
    assert_equal 1, result.count
  end

  test "it only accepts letter and numbers in name" do
    category = Category.new(name: "Cute Kitten-!")

    assert category.invalid?
  end
end
