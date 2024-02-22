class MessagesController < ApplicationController
  def create
    if params[:message][:body].empty?
      return
    end
    message = Message.new(msg_params)
    message.save!
  end

  private
  def msg_params
    params.require(:message).permit(:body, :receiver_id, :sender_id)
  end

end
