class CreateUserConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.integer :read_messages, default: 0
      t.timestamps
    end
  end
end
