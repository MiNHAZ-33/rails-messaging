class UsersController < ApplicationController
  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_id
  def show
    @users = User.all_except(current_user)
    # @user = User.find_by_id(params[:id])
    @message = Message.new
    filtered_messages = Message.get_messages(current_user.id, @user.id)
    @messages = filtered_messages.sort_by(&:created_at)
    @current_user_id = current_user.id
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