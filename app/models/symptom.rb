class Symptom < ApplicationRecord
  # エクササイズとの関連
  has_many :exercises, dependent: :destroy
  
  # 画像ファイル添付
  has_one_attached :image
  
  # バリデーション
  validates :name, presence: true
  validates :description, presence: true
  
  # スコープ
  scope :recent, -> { order(created_at: :desc) }
end