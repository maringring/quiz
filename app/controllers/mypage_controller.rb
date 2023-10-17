class MypageController < ApplicationController
  def admin
    email = session[:email]

    @user = User.find_by(email: email)
  end

  def update_name
    email = session[:email]
    @user = User.find_by(email: email)
    @user.update(name: params[:name])

    redirect_to mypage_admin_path
  end

  def update_password
    email = session[:email]
    @user = User.find_by(email: email)
    
    if @user.authenticate(params[:password])
      # @user.update(password_digest: params[:newpassword1])
      @user.password = params[:newpassword1]
      @user.save
      flash[:notice] = "비밀번호가 변경되었습니다."
      
    else
      flash[:notice] = "비밀번호를 확인해주세요."
      
    end

    redirect_to mypage_admin_path
  end
end
