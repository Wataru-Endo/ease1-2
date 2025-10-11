class Symptom < ApplicationRecord
  # 関連
  has_many :exercises, dependent: :destroy
  
  # 画像アタッチメント（症状のアイコン）
  has_one_attached :icon
  
  # バリデーション
  validates :name, presence: true
end
