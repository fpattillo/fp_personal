class AddIsRoomToConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations,
    :is_room,
    :boolean,
    null: false,
    default: false
  end
end
