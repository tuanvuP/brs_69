class Admin::ReviewsController < ApplicationController
  layout "admin_layout"

  def index
    @reviews = Review.all
  end
end
