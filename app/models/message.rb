class Message < ApplicationRecord

  belongs_to :room

  scope :get_messages, ->(user_1, user_2) {
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", user_1, user_2, user_2, user_1)
  }

  after_create_commit do
    broadcast_append_to self.room
    broadcast_to_sidebar(self.receiver_id, false)
    broadcast_to_sidebar(self.sender_id, true)
  end

  def broadcast_to_sidebar(user_id, highlight)
    broadcast_update_to "#{self.room.name}last_msg_#{user_id}", target: user_id, partial: highlight ? "messages/new_message_highlight" : "messages/new_message", locals: { message: self.body }
  end

end
