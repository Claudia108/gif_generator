ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'capybara/rails'
require 'pry-rails'
require 'mocha/test_unit'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    reset_session!
    ApplicationController.any_instance.unstub(:current_user)
  end
end
  # Add more helper methods to be used by all tests here...
