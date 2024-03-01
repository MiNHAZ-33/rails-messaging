class MessagesController < ApplicationController
  def create
    if params[:message][:body].empty?
      return
    end
    room = Room.where(name: msg_params[:room_id]).first
    message = Message.new(msg_params)
    message.room = room
    message.save!

  end

  private
  def msg_params
    params.require(:message).permit(:body, :receiver_id, :sender_id, :room_id)
  end

end


