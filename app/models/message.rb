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
    broadcast_update_to "#{sender_id}_last_msg", target: sender_id, partial: "users/last_message", locals:{user: sender, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body, message: self }
    broadcast_update_to "#{receiver_id}_last_msg", target: receiver_id, partial: "users/last_message", locals:{user: receiver, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body, message: self}
  end

  # def broadcast_to_sidebar(user_id, highlight)
  #   broadcast_update_to "#{self.room.name}last_msg_#{user_id}", target: user_id, partial: highlight ? "messages/new_message_highlight" : "messages/new_message", locals: { message: self.body }
  # end



end
