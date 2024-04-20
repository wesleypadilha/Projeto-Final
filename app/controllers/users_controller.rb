class UsersController < ApplicationController
    before_action :verify_logged

    def edit
    end

    def update
        if Current.user.update(user_params)
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :nickname)
    end
end