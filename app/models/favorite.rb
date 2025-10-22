class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  
  # 重複防止
  validates :user_id, uniqueness: { scope: :exercise_id }
  
  # スコープ
  scope :recent, -> { order(created_at: :desc) }
end