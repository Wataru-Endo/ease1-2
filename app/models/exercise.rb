class Exercise < ApplicationRecord
  belongs_to :symptom
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :schedules, dependent: :destroy
  
  # 動画ファイル添付
  has_one_attached :video_file
  
  # バリデーション
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  
  # 動画があるかチェック
  def has_video?
    video_file.attached? || youtube_url.present?
  end
  
  # YouTube URLからembedURLを生成
  def youtube_embed_url
    return nil unless youtube_url.present?
    
    # 様々なYouTube URLフォーマットに対応
    if youtube_url.include?('watch?v=')
      video_id = youtube_url.split('watch?v=')[1].split('&')[0]
    elsif youtube_url.include?('youtu.be/')
      video_id = youtube_url.split('youtu.be/')[1].split('?')[0]
    else
      return youtube_url
    end
    
    "https://www.youtube.com/embed/#{video_id}"
  end
end