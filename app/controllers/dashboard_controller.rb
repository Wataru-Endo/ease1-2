class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
    @favorites = @user.favorites.includes(:exercise)
  end
end
