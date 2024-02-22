class UsersController < ApplicationController
  def show
    @users = User.all_except(current_user)
    @user = User.find(params[:id])
    @message = Message.new
    @messages = Message.get_messages(current_user.id, @user.id)
    render 'homes/index'
  end
end