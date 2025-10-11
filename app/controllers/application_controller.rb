class ApplicationController < ActionController::Base
  #セッション管理のヘルパーメソッド
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    unless logged_in?
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end
  
  # ビューでも使えるようにする
  helper_method :current_user, :logged_in?
end