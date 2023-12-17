class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_later
      redirect_to root_path
    else
      redirect_to users_new_path
      flash[:notice] = "全てを作成してください。"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :birthday )
  end
end
