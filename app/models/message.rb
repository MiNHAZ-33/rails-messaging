class Message < ApplicationRecord
  belongs_to :room

  after_create_commit do
    broadcast_append_to self.room
    notify
  end

  def self.last_message(room_name)
    room = Room.find_by(name: room_name)
    if room
      room.messages.order(created_at: :desc).first
    end
  end


  def notify
    sender = User.find(self.sender_id)
    receiver = User.find(self.receiver_id)
    set_current_room_as_seen
    broadcast_update_to "#{self.room.name}_last_msg", target: sender_id, partial: "users/last_message", locals:{user: sender, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body,  seen_count: unseen_count }
    # update self sidebar
    broadcast_update_to "#{self.room.name}_last_msg", target: receiver_id, partial: "users/last_message", locals:{user: receiver, last_message_date: DateTime.now.strftime("%d %b"), last_message: self.body,  seen_count: 0}
  end

  def unseen_count
    count = self.room.messages.where(receiver_id: self.receiver_id, is_seen: false).count
    return count
  end

  def set_current_room_as_seen
    self.room.messages.where(receiver_id: self.sender_id, is_seen: false).update_all(is_seen: true)
  end

end
