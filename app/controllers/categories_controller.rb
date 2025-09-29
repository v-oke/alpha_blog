class CategoriesController < ApplicationController
  before_action :require_admin, except: [ :show, :index ]
  before_action :set_category, only: [ :show ]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def new
    @category = Category.new()
  end

  def create
    @category = Category.new(category_params)
    # @article.user = current_user
    # debugger
    if @category.save
      flash[:success] = "Category was successfully saved"
      redirect_to categories_path
    else
      Rails.logger.debug "Validation errors: #{@category.errors.full_messages.inspect}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
  if !logged_in? || (logged_in? and !current_user.admin?)
    flash[:danger] = "You have no rights, contact Admin"
    redirect_to root_path
  end
  end
end
