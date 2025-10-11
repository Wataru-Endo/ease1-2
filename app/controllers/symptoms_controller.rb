class SymptomsController < ApplicationController
  before_action :require_login

  def index
    @symptoms = Symptom.all
  end

  def show
    @symptom = Symptom.find(params[:id])
    @exercises = @symptom.exercises
  end

  def edit
    @symptom = Symptom.find(params[:id])
  end

  def update
    @symptom = Symptom.find(params[:id])
    if @symptom.update(symptom_params)
      redirect_to @symptom, notice: '症状が更新されました。'
    else
      render :edit
    end
  end

  private

  def symptom_params
    params.require(:symptom).permit(:name, :description)
  end
end