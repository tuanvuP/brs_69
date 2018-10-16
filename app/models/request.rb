class Request < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user

  validates :title, presence: true,
    length: {maximum: Settings.models.request.title_max_len}
  validates :content, presence: true,
    length: {in: Settings.models.request.content_min_len..Settings.models.request.content_max_len}

  self.per_page = Settings.models.request.self_per_page
end
