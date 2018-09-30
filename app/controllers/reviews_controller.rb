class ReviewsController < ApplicationController
  before_action :load_book
  before_action :load_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    @review.book_id = @book.id
    @review.user_id = current_user.id

    if @review.save
      flash[:success] = t "create_successfully"
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update_attributes review_params
    flash[:success] = t("update_successfully")
    redirect_to book_path @book
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit :rating, :content, :book_id, :user_id
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    render file: "public/404.html", status: :not_found, layout: false
  end

  def load_review
    @review = Review.find_by id: params[:id]
  end
end
