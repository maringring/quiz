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
              # 세션에 유저저장
              session[:email] = user.email 
              redirect_to '/main/new' and return #home/index
            else
              flash[:notice] = "Passwordが違います。ご確認ください。"
            end
          else
            flash[:notice] = "emailが違います。ご確認ください。"
          end
        else
          flash[:notice] = "email、Password全て入力してください。"
        end
        
        redirect_to '/home/index' and return
      end

      def destroy
        if current_user.present?
          cookies.delete :email
          cookies.delete :passowrd
          redirect_to home_index_path and return
        end
        redirect_to root_path, notice: '로그아웃되었습니다.'
        session[:email] = nil 
      end

    end