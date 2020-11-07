json.conversation do
  json.id @conversation.id
  json.name @conversation_name
end

json.messages @messages do |message|
  json.id message.id
  json.created_at message.created_at
  json.content message.content
  json.user message.user.email
end