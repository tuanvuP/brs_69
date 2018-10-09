class Book < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :book_status

  mount_uploader :book_img_file_name, PictureUploader

  delegate :name, to: :category

  validates :title, presence: true,
    length: {maximum: Settings.models.book.title_max_len}
  validates :author,
    length: {maximum: Settings.models.book.author_name_max_len}
  validates :description,
    length: {maximum: Settings.models.book.descrip_max_len}
  validates :category_id, presence: true

  self.per_page = Settings.models.book.self_per_page

  scope :search_by, ->value do
    where("title LIKE ?", "%#{value}%") if value.present?
  end
end
