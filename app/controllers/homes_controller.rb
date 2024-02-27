class HomesController < ApplicationController

  # GET /homes or /homes.json
  def index
    @users = User.all_except(current_user)
    @user = User.find_by_id(params[:id])
    @message = Message.new
    @current_user = @user
  end

end
