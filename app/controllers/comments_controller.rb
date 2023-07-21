class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.new(comment_params)
        if !@comment.save
            flash[:notice] = @comment.errors.full_messages.to_sentence
        end

        redirect_to article_path(params[:article_id])
    end

    def create_comment
        @comment = current_user.comments.new(comment_params)
        if !@comment.save
            flash[:notice] = @comment.errors.full_messages.to_sentence
        end

        redirect_to articles_path
    end

    private

    def comment_params
        params.require(:comment).permit(:content).merge(article_id: params[:article_id])
    end
end
