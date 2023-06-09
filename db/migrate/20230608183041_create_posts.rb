class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.text :text, null: false
      t.text :tag_name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :prefecture_city
      t.timestamps
    end
  end
end
