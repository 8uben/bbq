class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  mount_uploader :avatar, AvatarUploader

  # Юзер может создавать много событий
  has_many :events
  has_many :comments
  has_many :subscriptions

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end

  def self.find_for_social_network_oauth(access_token)
    # Достаём email из токена
    email = access_token.info.email
    user = where(email: email).first
    # Возвращаем, если нашёлся
    return user if user.present?

    # Если не нашёлся, достаём провайдера, айдишник и урл
    id = access_token.extra.raw_info.id
    provider = access_token.provider

    case provider
    when 'facebook'
      domain = 'facebook.com'
      url = "https://#{domain}/#{id}"
    when 'vkontakte'
      domain = 'vk.com'
      url = "https://#{domain}/id#{id}"
    end

    # Теперь ищем в базе запись по провайдеру и урлу
    # Если есть, то вернётся, если нет, то будет создана новая
    where(url: url, provider: provider).first_or_create! do |user|
      # Если создаём новую запись, прописываем email и пароль
      user.email = email || "#{id}@#{domain}"
      user.password = Devise.friendly_token.first(16)
      user.provider = provider
    end
  end
end
