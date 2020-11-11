class AddUserConversationToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :user_conversation, null: false, foreign_key: true
  end
end
