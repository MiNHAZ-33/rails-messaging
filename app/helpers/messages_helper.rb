module MessagesHelper
  include RoomsHelper
  # <%#= user.id == params[:id].to_i  ? "bg-background-color border-l-4 border-blue-500" : "border-b-2" %>"

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

  def last_message(user_id)
    if Current.user
      # message = Message.get_messages(Current.user.id, user_id)&.order(created_at: :desc).first
      room_name = get_name_by_id(Current.user.id, user_id)
      message = Message.last_message(room_name)
      if message
        return message
      end
    end
  end
  def selected_div(user_id, sender_id)
    if user_id == sender_id.to_i
      return "bg-background-color border-l-4 border-blue-500"
    else
      return "border-b-2"
    end
  end

  def initial_unseen_msg_count(room, user)
    room = Room.find_by(name: room)
    if room
    count = room.messages.where(sender_id: user, is_seen: false).count
      return count
    else
      return 0
    end
  end
end
