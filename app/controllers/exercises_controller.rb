class ExercisesController < ApplicationController
  before_action :require_login
  before_action :set_exercise, only: [:show, :edit, :update]

  def index
    @exercises = Exercise.all
  end

  def show
    # 個別のエクササイズページ
  end

  def edit
    # エクササイズ編集ページ
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "エクササイズを更新しました"
      redirect_to exercise_path(@exercise)
    else
      render :edit
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:title, :description, :duration, :youtube_url, :instructions, :steps, :video_file)
  end
end
