module Api
  module V1
    class ConversationsController < ApiController
      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      before_action :authenticate_user!
      def get_not_room_conversation_ids(user_id)
        conversation_ids = UserConversation.where("user_id = ?", user_id)
        not_room_conversations = conversation_ids.select { |conv| conv.conversation.is_room == false }
        return not_room_conversations.pluck(:conversation_id)
      end

      def redirect_or_create
        selected_ids_1 = get_not_room_conversation_ids(current_user.id)
        selected_ids_2 = get_not_room_conversation_ids(params[:other_user_id])
        common_ids = selected_ids_1 & selected_ids_2
        if common_ids.length > 0
          redirect_to api_v1_conversation_path(common_ids[0])
        else
          common_conversation = Conversation.new()
          common_conversation.save
          user_conversation_1 = UserConversation.new(
              :conversation_id => common_conversation.id,
              :user_id => current_user.id
          )
          user_conversation_2 = UserConversation.new(
              :conversation_id => common_conversation.id,
              :user_id => params[:other_user_id]
          )
          user_conversation_1.save
          user_conversation_2.save
          redirect_to api_v1_conversation_path(common_conversation.id)
        end
      end

      def show
        users_not_current = 0
        @conversation = Conversation.find_by("id = ?", params[:id])
        if @conversation.is_room == false
            @conversation.users.each do |user|
                if user.id != current_user.id
                    @conversation_name = user.email
                    users_not_current += 1
                end
            end
            if users_not_current == 2
                redirect_to api_v1_root_path
            end
        else
            @conversation_name = @conversation.title
        end
        @messages = @conversation.messages
      end

      def new_message
        if params[:content].include? "@" || params[:content]["#" ]
          @email = params[:content].split(" ").first[1..-1]
          @user = User.find_for_database_authentication(email: @email)
          if @user 
            ConversationsMailer.with(email: @email, params: params).new_order_email.deliver_now
          end
        end
        user_conversation = UserConversation.find_by(
            "user_id = ? AND conversation_id = ?",
            current_user.id, params[:id]
        )
        if user_conversation == nil
            user_conversation = UserConversation.new(
                :conversation_id => params[:id],
                :user_id => current_user.id
            )
            user_conversation.save
        end
        new_message = Message.new(
            :content => params[:content],
            :user_conversation_id => user_conversation.id
        )
        
        new_message = Message.new(
          :content => params[:content],
          :user_conversation_id => user_conversation.id
      )
        conversation = Conversation.find(params[:id])
        if new_message.save
            ConversationChannel.broadcast_to(conversation, 
              {content: params[:content], user: params[:user_email]})
        end
        redirect_to api_v1_conversation_path(params[:id])
      end
      
      def new_room
        new_room = Conversation.new(
            :title => params[:title],
            :is_room => true
        )
        new_room.save
        user_conversation = UserConversation.new(
            :conversation_id => new_room.id,
            :user_id => current_user.id
        )
        user_conversation.save
        redirect_to api_v1_conversation_path(new_room.id)
      end

    end
  end
end
