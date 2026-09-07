class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        flash[:success] = "管理者としてログインしました"
      else
        flash[:success] = "ログインしました"
      end
      redirect_to user_path(user), notice: "ログインに成功しました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new, status: :unprocessable_entity
    end
  end

  # 開発環境限定: ワンクリックログイン
  def dev_login
    return redirect_to login_path, alert: "この機能は開発環境でのみ利用可能です" unless Rails.env.development?

    user = User.find_or_create_by!(email: params[:role] == "admin" ? "admin@example.com" : "user@example.com") do |u|
      u.name = params[:role] == "admin" ? "管理者テスト" : "一般ユーザーテスト"
      u.password = "password"
      u.password_confirmation = "password"
      u.admin = params[:role] == "admin"
    end

    session[:user_id] = user.id
    flash[:success] = user.admin? ? "管理者としてログインしました" : "一般ユーザーとしてログインしました"
    redirect_to user_path(user)
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end