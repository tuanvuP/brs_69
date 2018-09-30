class BooksController < ApplicationController
  before_action :load_book, only: [:show, :destroy, :update, :edit]

  def index
    @books = Book.sort_by_desc.paginate page: params[:page],
      per_page: Settings.controller.book.per_page
  end

  def new
    @book = Book.new
    @categories = Category.all.map{ |m| [m.name, m.id] }
  end

  def show; end

  def destroy
    if @book.destroy
      flash[:success] = t "delete_successfully"
    else
      flash.now[:danger] = t "error_message"
    end
    redirect_to books_url
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "update_successfully"
      redirect_to @book
    else
      render :edit
    end
  end

  def edit; end

  def create
    @book = Book.new book_params
    @book.category_id = params[:category_id]

    if @book.save
      flash[:success] = t "create_successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit :title, :description, :author, :category_id
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    render file: "public/404.html", status: :not_found, layout: false
  end
end
