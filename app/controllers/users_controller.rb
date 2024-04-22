class UsersController < ApplicationController
  layout 'layouts/authentication', only: [:new]

  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :authenticate!, except: %i[create new]

  def create
    @user = User.create(user_params.except(:old_password))

    if @user.save
      redirect_to login_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params.except(:password, :password_confirmation))
      redirect_to profile_path
      return
    end

    render :edit, status: :unprocessable_entity
  end

  def edit_password
    @user = current_user
  end

  def update_password
    unless params[:user][:old_password].present?
      flash.now[:alert] = 'Incorrect old password'
      render :edit_password, status: :forbidden
      return
    end

    @user = current_user

    unless @user.authenticate(params[:user][:old_password])
      flash.now[:alert] = 'Password doesn\'t matches'
      render :edit_password, status: :forbidden
      return
    end

    if @user.update(user_params.except(:old_password))
      redirect_to profile_path
    else
      render :edit_password, status: :unprocessable_entity
    end

  end

  private

  def user_params
    if params[:user][:old_password].present?
      return params.require(:user).permit(:username, :email, :password, :password_confirmation, :old_password)
    end
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
