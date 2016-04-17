class Gif < ActiveRecord::Base
  belongs_to :category
  has_many :favorites
end
