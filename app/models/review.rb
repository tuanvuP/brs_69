class Review < ApplicationRecord
  after_save :update_average_ratings
  after_destroy :update_average_ratings

  belongs_to :book
  belongs_to :user

  delegate :name, to: :user

  validates :rating, presence: true
  validates :content, presence: true,
    length: {in: Settings.models.review.content_min_len..Settings.models.review.content_max_len}

  private

  def update_average_ratings
    if self.book.reviews.count > 0
      average_ratings = self.book.reviews.collect(&:rating).sum / self.book.reviews.count.to_f
    else
      average_ratings = 0
    end
    book.update_attributes(rates: average_ratings.round(1))
  end
end
