class SessionsController < ApplicationController
  layout 'layouts/authentication'

  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :authenticate!, only: [:destroy]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    unless @user
      flash.now[:alert] = 'Incorrect email or password.'
      render :new, status: :unprocessable_entity
      return
    end

    unless @user.authenticate(params[:user][:password])
      flash.now[:alert] = 'Incorrect email or password.'
      render :new, status: :unprocessable_entity
      return
    end

    after_login_path = session[:user_return_to] || root_path
    login @user
    remember @user if params[:user][:remember_me] == '1'
    redirect_to after_login_path, notice: 'Signed in.'
  end

  def destroy
    forget(current_user)
    logout
    redirect_to root_path, notice: 'Signed out.'
  end

  def new
  end
end
