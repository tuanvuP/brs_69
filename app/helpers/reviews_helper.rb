module ReviewsHelper
  def has_not_reviewed?
    if current_user.reviews.exists?(book: @book)
      return false
    else
      return true
    end
  end
end
