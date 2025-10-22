class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      if user.admin?
        flash[:success] = "👑 管理者としてログインしました"
      else
        flash[:success] = "👤 ログインしました"
      end
      
      redirect_to user_path(user), notice: "ログインに成功しました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end