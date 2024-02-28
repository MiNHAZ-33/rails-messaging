class MessagesController < ApplicationController
  def create
    # @message = Message.create(body: msg_params[:content], room_id: params[:user_id])

    room_name = get_name(params[:message][:sender_id], params[:message][:receiver_id])

    room = Room.where(name: room_name).first

    @message = Message.create(body: params[:message][:body], sender_id: params[:message][:sender_id], receiver_id: params[:message][:receiver_id], room: room)



    puts "Create message #{@message}"
    # if params[:message][:body].empty?
    #   return
    # end
    # message = Message.new(msg_params)
    # # if message.save!
    # #   respond_to do |format|
    # #     Turbo::StreamsChannel.broadcast_update_to  target: "last_msg_#{params[:sender_id]}", html: message
    # #   end
    # # end
    # message.save!
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


