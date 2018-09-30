class User < ApplicationRecord
  has_many :books
  has_many :reviews
  has_many :comments
  has_many :requests
  has_many :book_statuses
end
