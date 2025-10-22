class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_login, except: [:new, :create]
  before_action :require_owner_or_admin, only: [:show, :edit, :update]
  
  def show
    # ユーザー自身または管理者が閲覧可能
  end
  
  def new
    @user = User.new
  end
  
  def create
    user_params_with_admin = user_params.merge(admin: false)
    @user = User.new(user_params_with_admin)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "アカウントが作成されました"
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  
  def edit
    # ユーザー自身または管理者が編集可能
  end
  
  def update
    # パスワードが空の場合は除外
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, 
                                 :birth_date, :age, :gender, :height, :weight, 
                                 :primary_symptom, :avatar)
  end
  
  def require_owner_or_admin
    # あなたのUser modelの管理者権限チェック
    unless current_user == @user || current_user&.admin?
      flash[:alert] = "権限がありません"
      redirect_to root_path
    end
  end
end