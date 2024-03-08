module MessagesHelper
  # <%#= user.id == params[:id].to_i  ? "bg-background-color border-l-4 border-blue-500" : "border-b-2" %>"
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
