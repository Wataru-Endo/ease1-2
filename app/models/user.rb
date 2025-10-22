class User < ApplicationRecord
  has_secure_password
  
  has_one_attached :avatar

  # 関連
  has_many :favorites, dependent: :destroy
  has_many :favorite_exercises, through: :favorites, source: :exercise
  has_many :schedules, dependent: :destroy
  
  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  
  # お気に入り機能
  def favorited?(exercise)
    return false unless exercise
    favorites.exists?(exercise: exercise)
  end
  
  def add_favorite(exercise)
    return false unless exercise
    favorites.find_or_create_by(exercise: exercise)
  end
  
  def remove_favorite(exercise)
    return false unless exercise
    favorites.find_by(exercise: exercise)&.destroy
  end
  
  # 管理者判定
  def admin?
    admin == true
  end
  
  # 役割表示
  def role_display
    admin? ? '管理者' : 'ユーザー'
  end
end