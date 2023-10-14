class MypageController < ApplicationController
  def admin
    email = session[:email]

    @user = User.find_by(email: email)
  end
end
