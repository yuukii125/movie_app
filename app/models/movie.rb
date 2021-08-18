class Movie < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true

  # 保存する前にフォーマットを実行
  before_save do
    format_url = YoutubeUrlFormatter.format(url)
    if format_url.present?
      self.url = format_url
    else
      # 失敗した場合はバリデーションエラーを出す
      self.errors.add(:url, "YouTubeのURL以外は無効です")
      throw(:abort)
    end
  end
end
