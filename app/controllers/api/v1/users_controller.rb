# class Api::V1::UsersController < ApplicationController
#   before_action :authenticate_user!
#   def index
#     @other_users = User.where.not(id: current_user.id)
#     @group_conversations = Conversation.where("is_room = ?", true)
#   end
# end

module Api
  module V1
    class UsersController < ApiController
      before_action :authenticate_user!
      def index
        @other_users = User.where.not(id: current_user.id)
        @group_conversations = Conversation.where("is_room = ?", true)
      end
    end
  end
end