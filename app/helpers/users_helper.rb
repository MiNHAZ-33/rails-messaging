module UsersHelper
  def user_avatar(user_id)
    user = User.find(user_id)
    if user.avatar.attached?
      return url_for(user.avatar)
    else
      return "profile_avatar.jpg"
    end
  end
end