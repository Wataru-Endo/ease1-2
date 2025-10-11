class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  
  # バリデーション（同じユーザーが同じエクササイズを重複してお気に入りできないように）
  validates :user_id, uniqueness: { scope: :exercise_id }
end
