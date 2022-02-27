class MailSentAboutPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo)
    event = photo.event

    all_emails =
      (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user&.email]).uniq

    all_emails.each do |mail|
      EventMailer.photo(photo, mail).deliver_now
    end
  end
end
