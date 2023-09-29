class CookieController < ApplicationController
    def new
    end

    def create
        if params[:email].present? && params[:password].present?
          user = User.find_by(email: params[:email])
          if user.present?
            if user.authenticate(params[:password])
              cookies[:email] = user.email
              cookies[:password] = user.password_digest
              flash[:notice] = "LOGIN 成功"
              redirect_to '/home/index'
            else
              flash[:notice] = "Passwordが違います。ご確認ください。"
            end
          else
            flash[:notice] = "emailが違います。ご確認ください。"
          end
        else
          flash[:notice] = "email、Password全て入力してください。"
        end
        redirect_to cookie_new_path
      end

      def destroy
        if current_user.present?
          cookies.delete :email
          cookies.delete :passowrd
          redirect_to cookie_new_path
        end
      end

    end