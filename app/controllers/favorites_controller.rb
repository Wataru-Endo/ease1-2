class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_favorite, only: [:destroy]

  def index
    @favorites = current_user.favorites.includes(:exercise => :symptom)
  end

  def create
    @exercise = Exercise.find(params[:exercise_id])
    @favorite = current_user.favorites.find_or_initialize_by(exercise: @exercise)
    
    if @favorite.persisted?
      flash[:notice] = "既にお気に入りに登録済みです"
    else
      @favorite.save
      flash[:notice] = "お気に入りに追加しました"
    end
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: exercise_path(@exercise)) }
      format.json { render json: { status: 'success', favorited: true } }
    end
  end

  def destroy
    if params[:exercise_id]
      # エクササイズ詳細ページからの削除
      @exercise = Exercise.find(params[:exercise_id])
      @favorite = current_user.favorites.find_by(exercise: @exercise)
      @favorite&.destroy
      flash[:notice] = "お気に入りから削除しました"
      redirect_back(fallback_location: exercise_path(@exercise))
    else
      # お気に入り一覧からの削除
      @favorite.destroy
      flash[:notice] = "お気に入りから削除しました"
      redirect_to favorites_path
    end
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find(params[:id])
  end
end