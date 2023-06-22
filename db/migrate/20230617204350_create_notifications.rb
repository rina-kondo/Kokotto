class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id, null: false
      t.integer :comment_id, null: false
      t.string :action, null: false
      t.boolean :has_read, default: false, null: false
      t.timestamps
    end
  end
end
