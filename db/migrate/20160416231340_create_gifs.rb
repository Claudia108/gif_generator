class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.text :image_path
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
