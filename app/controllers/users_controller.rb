class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to root_path
    else
      redirect_to users_new_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
