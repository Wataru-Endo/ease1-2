class FavoritesController < ApplicationController
  before_action :require_login
  
  def index
    @favorites = current_user.favorites.includes(:exercise)
  end

  def show
    @favorite = current_user.favorites.find(params[:id])
    redirect_to @favorite.exercise
  end
  
  def create
    @exercise = Exercise.find(params[:exercise_id])
    if current_user.add_favorite(@exercise)
      flash[:success] = 'お気に入りに追加しました'
    else
      flash[:alert] = 'お気に入りの追加に失敗しました'
    end
    redirect_to @exercise
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path, notice: "お気に入りを解除しました"
  end
end