class UsersController < ApplicationController
  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_id
  def show
    @users = User.all_except(current_user)
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room(@room_name)
    @messages = @single_room.messages.order(created_at: :asc)
    @message = Message.new
    render 'homes/index'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private
  def get_name(user_1, user_2)
    user = [user_1, user_2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  def invalid_user_id
    redirect_to root_path
  end

end