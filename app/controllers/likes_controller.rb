class LikesController < ApplicationController
    def create
        @like = current_user.likes.new(like_params.except(:redirect_to))

        if !@like.save
            flash[:notice] = @like.errors.full_messages.to_sentence
        end
        entity = @like.entity
        article = entity.is_a?(Article) ? entity : entity.article
        like_params[:redirect_to] == "Articles" ? redirect_to(articles_path) : redirect_to(article)
    end

    # def create_like
    #     like = current_user.likes.new(like_params)

    #     if !like.save
    #         flash[:notice] = like.errors.full_messages.to_sentence
    #     end

    #     redirect_to articles_path
    # end

    def destroy
        @like = current_user.likes.find(params[:id])
        entity = @like.entity
        article = entity.is_a?(Article) ? entity : entity.article
        @like.destroy
        destroy_params[:redirect_to] == "Articles" ? redirect_to(articles_path) : redirect_to(article)
    end

    # def destroy_like
    #     byebug
    #     like = current_user.likes.find(params[:id])
    #     article = like.article
    #     like.destroy
    #     redirect_to articles_path
    # end

    private

    def like_params
        params.require(:like).permit(:entity_id, :entity_type, :redirect_to)
    end

    def destroy_params
        params.require(:like).permit(:redirect_to)
    end

end
