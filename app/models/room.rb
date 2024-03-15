class Room < ApplicationRecord
  has_many :messages

  def self.create_private_room(room_name)
    single_room = Room.create(name: room_name)
    single_room
  end

  def self.find_last_message_by_room(room)
    room = Room.find_by(name: room)
    if room
       room.messages.last
    end
  end

end
