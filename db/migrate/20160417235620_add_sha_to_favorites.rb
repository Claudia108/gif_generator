class AddShaToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :sha, :string
  end
end
