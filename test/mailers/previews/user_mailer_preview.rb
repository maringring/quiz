# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def welcome_email
        test_user = User.new(email: "amugae@gmail.com")

        UserMailer.with(user: test_user).welcome_email
    end
end
