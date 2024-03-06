module UsersHelper

  def get_name_by_id(user_1, user_2)
    user = [user_1, user_2].sort
    return "private_#{user[0]}_#{user[1]}"
  end

  def find_last_message(user_id)
    message = last_message(user_id)
    if message
      return message.body
    end
    return "No message"
  end

  def find_last_message_date(user_id)
    message = last_message(user_id)
    if message
      # return distance_of_time_in_words_to_now(message.created_at) + " ago"
      return message.created_at.strftime("%d %b")
    else
      return DateTime.now.strftime("%d %b")
    end
  end

  private
  def last_message(user_id)
    if Current.user
      message = Message.get_messages(Current.user.id, user_id)&.order(created_at: :desc).first
      if message
        return message
      end
    end
  end
end