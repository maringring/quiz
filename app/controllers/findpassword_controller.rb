class FindpasswordController < ApplicationController
  
  def new

  end
  

  def user_confirm
    email = params[:email]
    session[:email] = email

    year = params["birthday(1i)"]
    month = params["birthday(2i)"]
    day = params["birthday(3i)"]
    birthday = "#{year}-#{month}-#{day}"

    puts "Email: #{email}, Birthday: #{birthday}"
  
    if email.present? && birthday.present?
      user = User.find_by(email: params[:email], birthday: birthday)
  
      if user.present?
        redirect_to '/findpassword/change_password'
      else
        flash[:notice] = "入力された情報がユーザー情報と違います。確認してください。"
        render :new
      end
    else
      flash[:notice] = "e-mailと誕生日の両方を入力してください。"
      render :new
    end
  end

  def change_password

  end
  
  def update
    email = session[:email]
    @user = User.find_by(email: email)
    pw1 = params[:newpassword1]
    pw2 = params[:newpassword2]
    
    if (pw1 == pw2)
      @user.password = params[:newpassword1]
      @user.save
      flash[:notion] = "暗証番号が変更できました。"
      redirect_to root_path
    else
     
      flash[:notice] = "passwordを確認してください"
    end
  end
end
