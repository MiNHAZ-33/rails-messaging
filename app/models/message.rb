class Message < ApplicationRecord

  belongs_to :room

  scope :get_messages, ->(user_1, user_2) {
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", user_1, user_2, user_2, user_1)
  }

  # after_create_commit do
  #   broadcast_append_to "messages"
  # end

  after_create_commit {broadcast_append_to self.room}

end
