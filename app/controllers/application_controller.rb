class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def require_login
    unless current_user
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
