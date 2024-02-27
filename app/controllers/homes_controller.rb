class HomesController < ApplicationController

  # GET /homes or /homes.json
  def index
    @users = User.all_except(current_user)
    @user = User.find_by_id(params[:id])
    # @last_message = Message.find_last_message(@user.id)
    @message = Message.new
    @current_user = @user
  end

end
