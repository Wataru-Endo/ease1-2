class User < ApplicationRecord
  # パスワード機能
  has_secure_password
  
  # 関連
  has_many :favorites, dependent: :destroy
  has_many :favorite_exercises, through: :favorites, source: :exercise
  has_many :schedules, dependent: :destroy
  
  # 画像アタッチメント
  has_one_attached :avatar
  
  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, allow_nil: true
  
  # お気に入りチェック用メソッド
  def favorited?(exercise)
    favorites.exists?(exercise: exercise)
  end
  
  # お気に入り追加
  def add_favorite(exercise)
    favorites.find_or_create_by(exercise: exercise)
  end
  
  # お気に入り削除
  def remove_favorite(exercise)
    favorites.find_by(exercise: exercise)&.destroy
  end
end
