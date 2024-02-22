class MessagesController < ApplicationController
  def create
    puts "Message is creating"
    @message = Message.create(body: params[:message][:body], sender_id: current_user.id, receiver_id: params[:message][:receiver_id])
    puts "From #{@message}"
  end
end
