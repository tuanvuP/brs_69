class Admin::ReviewsController < ApplicationController
  layout "admin_layout"

  before_action :load_review, only: [:edit, :update, :destroy]

  def edit; end

  def index
    @reviews = Review.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.admin.reviews.per_page
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "update_successfully"
      redirect_to admin_reviews_path
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "delete_successfully"
    else
      flash[:danger] = t "error_message"
    end
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit :rating, :content, :book_id, :user_id
  end

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    render file: "public/404.html", status: :not_found, layout: false
  end
end
