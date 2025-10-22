class ExercisesController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  
  def index
    @exercises = Exercise.all.order(created_at: :desc)
  end
  
  def show
  end
  
  def new
    @exercise = Exercise.new
    @symptoms = Symptom.all
  end
  
  def create
    @exercise = Exercise.new(exercise_params)
    
    if @exercise.save
      flash[:success] = "エクササイズを作成しました"
      redirect_to @exercise
    else
      @symptoms = Symptom.all
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @symptoms = Symptom.all
  end
  
  def update
    if @exercise.update(exercise_params)
      flash[:success] = "エクササイズを更新しました"
      redirect_to @exercise
    else
      @symptoms = Symptom.all
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @exercise.destroy
    flash[:success] = "エクササイズを削除しました"
    redirect_to exercises_path
  end
  
  private
  
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end
  
  def exercise_params
    params.require(:exercise).permit(
      :title, :description, :duration, :youtube_url, :video_file, 
      :instructions, :steps, :published, :image, :symptom_id
    )
  end
  
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to exercises_path
    end
  end
end