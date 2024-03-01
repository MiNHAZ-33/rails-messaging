class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_id
  def show
    @users = User.all_except(current_user)
    @room_name = get_name_by_id(current_user.id, @user.id)
    @room = Room.where(name: @room_name).first || Room.create_private_room(@room_name)
    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new
    render 'homes/index'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def invalid_user_id
    redirect_to root_path
  end

end