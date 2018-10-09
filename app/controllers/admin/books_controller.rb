class Admin::BooksController < ApplicationController
  layout "admin_layout"

  def index
    @books = Book.all
  end
end
