module ReviewsHelper
  def has_not_reviewed?
    current_user.reviews.exists?(book: @book) ? (return false) : (return true)
  end
end
