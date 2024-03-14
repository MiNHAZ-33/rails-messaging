class SessionsController < Devise::SessionsController
  def destroy
    current_user.update(status: false)
    super
  end
end