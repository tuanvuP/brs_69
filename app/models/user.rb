class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :reviews

  validates :name, presence: true,
    length: {maximum: Settings.models.user.name.max_size}
  validates :email, presence: true,
    length: {maximum: Settings.models.user.email.max_size},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  validates :password, presence: true,
    length: {minimum: Settings.models.user.password.min_size}, allow_nil: true

  enum role: {user: 0, admin: 1}

  has_secure_password

  before_save {email.downcase!}

end
