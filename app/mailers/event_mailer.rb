class EventMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.subscription.subject
  #
  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    # Берём у юзер его email
    # Subject тоже можно переносить в локали
    mail to: @event.user.email, subject: default_i18n_subject(event_title: @event.title)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.comment.subject
  #
  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: default_i18n_subject(event_title: @event.title)
  end

  def photo(photo, email)
    @photo = photo
    @event = photo.event

    mail to: email, subject: default_i18n_subject(event_title: @event.title)
  end
end
