class Room < ApplicationRecord
  has_many :messages
  # has_many :users
  # after_create_commit {broadcast_append_to 'rooms'}

  def self.create_private_room(room_name)
    single_room = Room.create(name: room_name)
    single_room
  end

end
