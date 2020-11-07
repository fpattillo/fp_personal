class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @conversation = Conversation.find_by(id: params[:conversation])
    stream_for @conversation
  end

  def received(data)
    Conversation.broadcast_to(@conversation, {
      conversation: @conversation
    })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
