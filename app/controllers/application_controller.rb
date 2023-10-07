class ApplicationController < ActionController::Base
    helper_method :current_user
  def current_user
    @current_user ||= User.find_by(email: cookies[:email], password_digest: cookies[:password]) || User.find_by(email: session[:email])
  end
end
