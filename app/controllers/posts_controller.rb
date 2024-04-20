class PostsController < ApplicationController
    before_action :verify_logged

    def myposts    
        @user_posts = index
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = Current.user.id
        if @post.save
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def index
        Post.sorted.where(user_id: Current.user.id)
    end

    def delete
        @post = Post.find(params[:post_id])
        if @post.destroy
            redirect_to posts_path
        end
    end

    def edit
        @post = Post.find(params[:post_id])
    end

    def update
        @post = Post.find(params[:post_id])
        if @post.update(post_params)
            redirect_to posts_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
