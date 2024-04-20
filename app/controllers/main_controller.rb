class MainController < ApplicationController
    def index
        if session[:user_id]
            @vis = false
            @user = User.find_by(id: session[:user_id])
        end
        @posts = Post.sorted
        @pagy, @posts = pagy(@posts)
    end
end
