class HomesController < ApplicationController
  # GET /homes or /homes.json
  def index
    @users = User.all_except(current_user)
  end

end
