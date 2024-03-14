class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance_channel"
    current_user.update(status: true)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_stream_from "appearance_channel"
    current_user.update(status: false)
  end

  def offline
    current_user.update(status: false)
  end
end
