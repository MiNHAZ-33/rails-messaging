module MessagesHelper
  include RoomsHelper

  def find_last_message_and_date(room)
    message = last_message(room)
    if message
      last_message_body = message.body
      last_message_date = message.created_at.strftime("%d %b")
    else
      last_message_body = "No message"
      last_message_date = DateTime.now.strftime("%d %b")
    end
    return last_message_body, last_message_date
  end

  def last_message(room)
    Room.find_last_message_by_room(room)
  end

  def selected_div(user_id, sender_id)
    if user_id == sender_id.to_i
       "bg-background-color border-l-4 border-blue-400"
    else
      "border-b-2"
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
