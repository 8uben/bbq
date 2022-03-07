class MailSentAboutCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    event = comment.event

    # Собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user&.email]).uniq

    # По адресам из этого массива делаем рассылку
    # Как и в подписках, берём EventMailer и его метод comment с параметрами
    # И отсылаем в том же потоке
    all_emails.each do |mail|
      EventMailer.comment(comment, mail).deliver_now
    end
  end
end
