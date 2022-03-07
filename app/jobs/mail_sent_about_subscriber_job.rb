class MailSentAboutSubscriberJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    EventMailer.subscription(subscription).deliver_now
  end
end
