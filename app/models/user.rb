class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :books
  has_many :reviews
  has_many :comments
  has_many :requests
  has_many :book_status
  has_many :active_follows, class_name: Follow.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: Follow.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

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

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def downcase_email
    self.email = email.downcase
  end

end
