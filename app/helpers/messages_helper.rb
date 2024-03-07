module MessagesHelper
  # <%#= user.id == params[:id].to_i  ? "bg-background-color border-l-4 border-blue-500" : "border-b-2" %>"
  def selected_div(user_id, sender_id)
    if user_id == sender_id.to_i
      return "bg-background-color border-l-4 border-blue-500"
    else
      return "border-b-2"
    end
  end

  def new_msg(user_id, sender_id)
    # if user_id == sender_id.to_i
    #   return "bg-blue-300 "
    # end
  end

end
