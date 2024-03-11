class SearchController < ApplicationController
  def users
    query = params[:query]
    users = User.all_except(current_user).where("username LIKE ?", "%#{query}%")
    render json: users
  end
end