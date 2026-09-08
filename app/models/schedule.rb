class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :exercise

  # バリデーション
  validates :scheduled_at, presence: true
  validates :completed, inclusion: { in: [ true, false ] }

  # スコープ（便利なメソッド）
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :today, -> { where(scheduled_at: Date.current.all_day) }
end
