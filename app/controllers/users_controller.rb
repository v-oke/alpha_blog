class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      Rails.logger.debug "Validation errors: #{@user.errors.full_messages.inspect}"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end