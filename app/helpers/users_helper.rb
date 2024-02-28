module UsersHelper
  def find_last_message(user_id)
    last_message_sent = Message.where(sender_id: user_id).order(created_at: :desc).first
    last_message_received = Message.where(receiver_id: user_id).order(created_at: :desc).first

    last_message = [last_message_sent, last_message_received].compact.max_by(&:created_at)

    if last_message
      return last_message.body
    else
      return "No message"
    end
  end
end