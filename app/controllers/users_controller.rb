class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  # Девайзовский фильтр, который посылает незалогинившихся юзеров
  # Просматривать профили могут и анонимы
  before_action :authenticate_user!, except: [:show]

  # Задаем объект @user для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  # GET /users/1 or /users/1.json
  def show
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def set_current_user
    @user = current_user
  end
end
