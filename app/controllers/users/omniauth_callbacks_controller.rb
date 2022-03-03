class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    social_network
  end

  def vkontakte
    social_network
  end

  private

  def social_network
    # Дёргаем метод модели, который найдёт пользователя
    @user = User.find_for_social_network_oauth(request.env['omniauth.auth'])
    kind = @user.provider.capitalize

    # Если юзер есть, то логиним и редиректим на его страницу
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: kind)
      sign_in_and_redirect @user, event: :authentication
      # Если неудачно, то выдаём ошибку и редиректим на главную
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: kind,
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end
