class PublicpostsController < ApplicationController
    def show
        @comment = Comment.new
        @post = Post.find(params[:post_id])
        @comments = Comment.sorted.where(post_id: params[:post_id])
        @nicknames = []
        @comments.each do |com|
            if com.user_id
                searched_user = User.find_by(id: com.user_id)
                @nicknames.push(searched_user.nickname)
            end
        end
    end

    def create_comment
        @comment = Comment.new(comment_params)
        if Current.user
            @comment.user_id = Current.user.id
        end
        @post = Post.find(params[:comment][:post_id])
        if @comment.save
            @comments = Comment.sorted.where(post_id: @post.id)
            redirect_to '/' + @comment.post_id.to_s 
        else
            render :show, status: :unprocessable_entity
        end
    end

    def get_comments
        Post.sorted.where(user_id: Current.user.id)
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end
end