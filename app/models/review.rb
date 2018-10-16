class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rating, presence: true
  validates :content, presence: true,
    length: {in: Settings.models.review.content_min_len..Settings.models.review.content_max_len}
end
