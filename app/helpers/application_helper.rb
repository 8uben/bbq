module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }
    .stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} my-3", role: "alert") do
          concat content_tag(:button, nil, class: "btn-close float-end", type: 'button', data: { 'bs-dismiss' => 'alert' }, 'aria-label'=> "Close")
          concat message
        end
      )
    end

    nil
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end
end
