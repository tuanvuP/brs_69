class Book < ApplicationRecord
  # has_many :reviews, dependent: :destroy
  # has_many :book_status
  # belongs_to :user
  belongs_to :category

  validates :title, presence: true,
    length: {maximum: Settings.models.book.title_max_len}
  validates :author,
    length: {maximum: Settings.models.book.author_name_max_len}
  validates :description,
    length: {maximum: Settings.models.book.descrip_max_len}

  scope :sort_by_desc, ->{order(created_at: :desc)}
end
