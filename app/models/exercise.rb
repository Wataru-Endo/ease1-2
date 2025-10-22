# app/models/exercise.rb
class Exercise < ApplicationRecord
  # 関連
  belongs_to :symptom
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :schedules, dependent: :destroy
  
  # 画像・動画ファイル
  has_one_attached :image
  has_one_attached :video_file
  
  # カテゴリの定数を追加
  CATEGORIES = ['運動', 'ストレッチ', 'セルフケア', 'リハビリ'].freeze
  
  # バリデーション
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  
  # スコープ
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :selfcare, -> { where(category: 'セルフケア') }
  
  # お気に入り数
  def favorites_count
    favorites.count
  end
  
  # 動画があるかどうか
  def has_video?
    youtube_url.present? || video_file.attached?
  end
  
  # セルフケアかどうかの判定
  def selfcare?
    category == 'セルフケア'
  end

  def youtube_embed_url
    return nil if youtube_url.blank?
    youtube_url.gsub("watch?v=", "embed/")
  end

end