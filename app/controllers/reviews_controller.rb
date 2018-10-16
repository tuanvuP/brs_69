class ReviewsController < ApplicationController
  before_action :load_book
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :has_reviewed?, only: [:new]

  def new; end

  def index
    @reviews = @book.reviews.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.reviews.per_page
  end

  def create
    @review = @book.reviews.build review_params
    @review.user_id = current_user.id

    if @review.save
      flash[:success] = t "create_successfully"
      redirect_to book_path @book
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update_attributes review_params
    flash[:success] = t "update_successfully"
    redirect_to book_path @book
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "delete_successfully"
    else
      flash.now[:danger] = t "error_message"
    end
    redirect_to book_path @book
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
    return if @review
    render file: "public/404.html", status: :not_found, layout: false
  end

  def has_reviewed?
    if logged_in?
      if current_user.reviews.exists?(book: @book)
        flash[:danger] = t "has_reviewed"
        redirect_to book_path(@book)
      end
    else
      flash[:danger] = t "please_login"
      redirect_to login_path
    end
  end
end
