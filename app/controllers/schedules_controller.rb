class SchedulesController < ApplicationController
  before_action :require_login
  before_action :set_schedule, only: [ :show, :edit, :update, :destroy ]

  def index
    @schedules = current_user.schedules.includes(:exercise).order(scheduled_at: :asc)
  end

  def show
  end

  def new
    @schedule = current_user.schedules.new(exercise_id: params[:exercise_id])
    @exercises = Exercise.published
  end

  def create
    @schedule = current_user.schedules.new(schedule_params)

    if @schedule.save
      flash[:success] = "スケジュールを登録しました"
      redirect_to schedules_path
    else
      @exercises = Exercise.published
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @exercises = Exercise.published
  end

  def update
    if @schedule.update(schedule_params)
      flash[:success] = "スケジュールを更新しました"
      redirect_to schedules_path
    else
      @exercises = Exercise.published
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    flash[:success] = "スケジュールを削除しました"
    redirect_to schedules_path
  end

  private

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:exercise_id, :scheduled_at, :completed)
  end
end
