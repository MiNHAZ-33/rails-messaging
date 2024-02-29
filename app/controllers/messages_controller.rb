class MessagesController < ApplicationController
  def create
    if params[:message][:body].empty?
      return
    end
    room_name = get_name(params[:message][:sender_id], params[:message][:receiver_id])
    room = Room.where(name: room_name).first
    Message.create(body: params[:message][:body], sender_id: params[:message][:sender_id], receiver_id: params[:message][:receiver_id], room: room)
  end

  private
  def msg_params
    params.require(:message).permit(:body, :receiver_id, :sender_id)
  end

  def get_name(user_1, user_2)
    user = [user_1, user_2].sort
    "private_#{user[0]}_#{user[1]}"
  end

end


