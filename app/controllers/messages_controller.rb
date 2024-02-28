class MessagesController < ApplicationController
  def create
    if params[:message][:body].empty?
      return
    end
    message = Message.new(msg_params)
    # if message.save!
    #   respond_to do |format|
    #     Turbo::StreamsChannel.broadcast_update_to  target: "last_msg_#{params[:sender_id]}", html: message
    #   end
    # end
    message.save!

  end

  private
  def msg_params
    params.require(:message).permit(:body, :receiver_id, :sender_id)
  end
end


