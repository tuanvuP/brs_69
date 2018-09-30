class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :book_status
  belongs_to :user
  belongs_to :category
end
