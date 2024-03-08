class Message < ApplicationRecord

  belongs_to :room

  scope :get_messages, ->(user_1, user_2) {
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", user_1, user_2, user_2, user_1)
  }

  after_create_commit do
    broadcast_append_to self.room
    # broadcast_to_sidebar(self.receiver_id, false)
    # broadcast_to_sidebar(self.sender_id, true)
    notify
  end

  def notify
    sender = User.find(self.sender_id)
    receiver = User.find(self.receiver_id)
    set_current_room_as_seen
    broadcast_update_to "#{self.room.name}_last_msg", target: sender_id, partial: "users/last_message", locals:{user: sender, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body, message: self, seen_count: unseen_count }
    # update self sidebar
    broadcast_update_to "#{self.room.name}_last_msg", target: receiver_id, partial: "users/last_message", locals:{user: receiver, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body, message: self, seen_count: 0}
  end

  def unseen_count
    count = self.room.messages.where(receiver_id: self.receiver_id, is_seen: false).count
    return count
  end

  def set_current_room_as_seen
    self.room.messages.where(receiver_id: self.sender_id, is_seen: false).update_all(is_seen: true)
  end

  # def broadcast_to_sidebar(user_id, highlight)
  #   broadcast_update_to "#{self.room.name}last_msg_#{user_id}", target: user_id, partial: highlight ? "messages/new_message_highlight" : "messages/new_message", locals: { message: self.body }
  # end



end
