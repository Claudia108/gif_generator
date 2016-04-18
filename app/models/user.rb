class User < ActiveRecord::Base
  has_secure_password
  has_many :favorites
  has_many :gifs, through: :favorites
  has_many :categories, through: :gifs

  enum role: %w(default admin)

  validates :username, presence: true, uniqueness: true
end
