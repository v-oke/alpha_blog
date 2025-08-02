class ArticlesController < ApplicationController
  before_action :set_article, only: [ :edit, :destroy, :update, :show ]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was successfully saved"
      redirect_to article_path(@article)
    else
      Rails.logger.debug "Validation errors: #{@article.errors.full_messages.inspect}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully Updated"
      redirect_to article_path(@article)
    else
      Rails.logger.debug "Validation errors: #{@article.errors.full_messages.inspect}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:alert] = "Article was successfully Deleted"
    #redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
