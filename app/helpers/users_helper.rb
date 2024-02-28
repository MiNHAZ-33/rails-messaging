module UsersHelper
  def find_last_message(user_id)
    message = Message.get_messages(current_user.id, user_id)&.order(created_at: :desc).first
    if message
      return message.body
    else
      return "No message"
    end
  end
end