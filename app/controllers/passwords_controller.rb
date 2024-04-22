class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated
  layout "mailer"

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    unless @user.present?
      redirect_to root_path, notice: "If that user exists we've sent instructions to their email."
      return
    end

    @user.send_password_reset_email!
    redirect_to root_path, notice: "If that user exists we've sent instructions to their email."

  end

  def edit
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
    if @user.nil?
      redirect_to new_password_path, alert: "Invalid or expired token."
    end
  end

  def new
  end

  def update
    @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)

    unless @user
      flash.now[:alert] = "Invalid or expired token."
      render :new, status: :unprocessable_entity
      return
    end

    if @user.update(password_params)
      redirect_to login_path, notice: "Sign in."
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end

  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
