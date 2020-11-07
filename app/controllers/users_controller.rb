class UsersController < ApplicationController
    before_action :authenticate_user!
    def index
        @other_users = User.where.not(id: current_user.id)
        @group_conversations = Conversation.where("is_room = ?", true)
    end
end