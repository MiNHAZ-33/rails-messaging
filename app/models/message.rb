class Message < ApplicationRecord

  scope :get_messages, ->(user_1, user_2) {
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", user_1, user_2, user_2, user_1)
  }

  scope :find_last_message, ->(user){
    where("sender_id = ?", user).order(created_at: :desc).first
  }

  after_create_commit {broadcast_append_to "messages"}

end
