class SearchController < ApplicationController
  def users
    query = params[:query]
    puts "Searching"
    users = User.where("username LIKE ?", "%#{query}%")
    render json: users
  end
end