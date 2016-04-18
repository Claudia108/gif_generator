class Favorite < ActiveRecord::Base
  validates :sha, uniqueness: true
  
  belongs_to :gif
  belongs_to :user
end
