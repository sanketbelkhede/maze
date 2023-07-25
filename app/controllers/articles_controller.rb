require 'csv'
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ edit update destroy ]
  before_action :ensure_current_user

  def index
    @articles = Article.includes(:user)
    @article = Article.new
  end

  def myarticles
    @user = current_user
    @articles = @user.articles
  end

  def download_csv
    articles = Article.includes(:comments, :likes)
    csv_data = CSV.generate do |csv|
        csv << ['Title', 'Comments', 'Likes']
        articles.each do |article|
            csv << [article.title, article.comments.count, article.likes.count]
        end
    end
    send_data csv_data, filename: 'articles.csv'
  end

  def download_xlsx
    articles = Article.includes(:comments, :likes)
    csv_data = CSV.generate do |csv|
        csv << ['Title', 'Comments', 'Likes']
        articles.each do |article|
            csv << [article.title, article.comments.count, article.likes.count]
        end
    end
    send_data csv_data, filename: 'articles.xlsx'
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to articles_path, notice: "Article successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "Article successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  def private
    @article = Article.find(params[:id])
    @article.update(privacy: true)
    redirect_to myarticles_path
  end

  def public
    @article = Article.find(params[:id])
    @article.update(privacy: false)
    redirect_to myarticles_path
  end

  private

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :privacy)
    end
end
