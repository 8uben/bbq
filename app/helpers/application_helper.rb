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

  # Если у пользователя есть собственный аватар, то показываем его,
  # иначе — стандартную иконку.
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # Возвращает адрес рандомной фотки события, если есть хотя бы одна
  # Или ссылку на картинку по умолчанию
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/event.jpg')
    end
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_pack_path('media/images/event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user.png')
    end
  end
end
