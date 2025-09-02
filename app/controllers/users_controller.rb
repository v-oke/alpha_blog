class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :destroy, :update, :show ]

  def index
    @users = User.paginate(page: params[:page], per_page:2)
  end

  def new
    @user = User.new
  end

  def create
    debugger
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      Rails.logger.debug "Validation errors: #{@user.errors.full_messages.inspect}"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # debugger
    if @user.update(user_params)
      flash[:success] = "User was successfully Updated"
      redirect_to edit_user_path(@user)
    else
      Rails.logger.debug "Validation errors: #{@user.errors.full_messages.inspect}"
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page:2)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
      @user = User.find(params[:id])
  end
end
