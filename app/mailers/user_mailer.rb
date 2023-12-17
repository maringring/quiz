class UserMailer < ApplicationMailer

    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: '会員登録ありがとうございます。')
    end
end
