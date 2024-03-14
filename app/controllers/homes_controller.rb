class HomesController < ApplicationController
  before_action :set_current_user
  # GET /homes or /homes.json
  def index
    @users = User.all_except(current_user)
  end

  private
  def set_current_user
    puts "Setting current user"
    Current.user = current_user
    current_user.update(status: true)
  end


end
