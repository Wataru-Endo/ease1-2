class SymptomsController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_symptom, only: [:show, :edit, :update, :destroy]
  
  def index
    @symptoms = Symptom.all.order(:name)
  end
  
  def show
    @exercises = @symptom.exercises
  end
  
  def new
    @symptom = Symptom.new
  end
  
  def create
    @symptom = Symptom.new(symptom_params)
    
    if @symptom.save
      flash[:success] = "症状を作成しました"
      redirect_to @symptom
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @symptom.update(symptom_params)
      flash[:success] = "症状を更新しました"
      redirect_to @symptom
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @symptom.destroy
    flash[:success] = "症状を削除しました"
    redirect_to symptoms_path
  end
  
  private
  
  def set_symptom
    @symptom = Symptom.find(params[:id])
  end
  
  def symptom_params
    params.require(:symptom).permit(:name, :description, :image)
  end
  
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to symptoms_path
    end
  end
end