class User < ActiveRecord::Base
  has_secure_password

  enum role: %w(default admin)

  # validates :username, presence: true, uniqueness: true
  # validates :password, presence: true, uniqueness: true
end
