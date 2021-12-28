class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
