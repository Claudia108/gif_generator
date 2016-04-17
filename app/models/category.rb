class Category < ActiveRecord::Base
  has_many :gifs
  validates :name, presence: true,
                   uniqueness: true,
                   format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows one word"}

end
