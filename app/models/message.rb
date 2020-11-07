class Message < ApplicationRecord
    belongs_to :user_conversation
    has_one :user, through: :user_conversation
    has_one :conversation, through: :user_conversation
end
