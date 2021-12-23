class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  # Проверки user_name и user_email выполняются,
  # только если user не задан
  # То есть для анонимных пользователей
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true,
    format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  before_validation :check_uniqueness_email, unless: -> { user.present? }

  # Если есть юзер, выдаем его имя,
  # если нет – дергаем исходный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # Если есть юзер, выдаем его email,
  # если нет – дергаем исходный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def check_uniqueness_email
    if User.find_by(email: user_email)
      errors.add(:user_email, :email_used)
    end
  end
end
