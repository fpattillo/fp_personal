json.other_users @other_users do |user|
  json.id user.id
  json.email user.email
end

json.group_conversations @group_conversations do |conversation|
  json.id conversation.id
  json.title conversation.title
end