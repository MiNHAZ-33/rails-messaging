module RoomsHelper
  def get_name_by_id(user_1, user_2)
    user = [user_1, user_2].sort
    return "private_#{user[0]}_#{user[1]}"
  end
end