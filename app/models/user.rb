class User < ApplicationRecord

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: Settings.user.name.max_size}
  validates :email, presence: true, length: {maximum: Settings.user.email.max_size},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: Settings.user.password.min_size}

  has_secure_password

  has_many :books
  has_many :reviews
  has_many :comments
  has_many :requests
  has_many :book_status
end
