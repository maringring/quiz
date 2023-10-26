class MypageController < ApplicationController
  def admin
    email = session[:email]

    @user = User.find_by(email: email)
  end

  def update_name
    email = session[:email]
    @user = User.find_by(email: email)
    @user.update(name: params[:name])
    flash[:notice] = "名前が変更されました。"

    redirect_to mypage_admin_path
  end

  def update_password
    email = session[:email]
    @user = User.find_by(email: email)
    
    if @user.authenticate(params[:password])
      # @user.update(password_digest: params[:newpassword1])
      @user.password = params[:newpassword1]
      @user.save
      flash[:notice] = "パスワードが変更されました。"
      
    else
      flash[:notice] = "パスワードを確認してください。"
      
    end

    redirect_to mypage_admin_path
  end
end
