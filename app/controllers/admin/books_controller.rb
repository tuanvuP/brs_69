class Admin::BooksController < ApplicationController
  layout "admin_layout"

  before_action :load_book, only: [:edit, :update, :destroy]
  before_action :load_category, except: [:destroy, :index, :show]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    @book.category_id = params[:category_id]

    if @book.save
      flash[:success] = t "create_successfully"
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def edit; end

  def index
    @books = Book.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.admin.books.per_page
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "update_successfully"
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "delete_successfully"
    else
      flash[:danger] = t "error_message"
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit :title, :description, :author, :category_id,
      :book_img_file_name
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    render file: "public/404.html", status: :not_found, layout: false
  end

  def load_category
    @categories = Category.all.map{ |m| [m.name, m.id] }
  end
end
