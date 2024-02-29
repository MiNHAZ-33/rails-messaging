module UsersHelper
  def find_last_message(user_id)
    if Current.user
      message = Message.get_messages(Current.user.id, user_id)&.order(created_at: :desc).first
      if message
        return message.body
      else
        return "No message"
      end
    else
      return "No Message"
    end
  end

  def get_name_by_id(user_1, user_2)
    user = [user_1, user_2].sort
    return "private_#{user[0]}_#{user[1]}"
  end
end