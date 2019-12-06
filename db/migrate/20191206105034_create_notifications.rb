class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :comment_id
      t.integer :user_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
