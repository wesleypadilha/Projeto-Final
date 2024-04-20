class RegistrationsController < ApplicationController
    before_action :verify_logged
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Conta criada com sucesso"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
    end

    def verify_logged
        if Current.user
            redirect_to root_path
        end
    end
end
