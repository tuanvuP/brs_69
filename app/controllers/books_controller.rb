class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create, :search]
  before_action :load_category, except: [:index, :show, :destroy, :search]

  def index
    if params[:category].blank?
      @books = Book.sort_by_created_desc.paginate page: params[:page]
    else
      category = Category.find_by name: params[:category]
      if category.present?
        @books = category.books.sort_by_created_desc.paginate page: params[:page]
      else
        render file: "public/404.html", status: :not_found, layout: false
      end
    end
  end

  def new
    if logged_in? && current_user.admin?
      @book = Book.new
    else
      flash[:danger] = t "deny_access"
      redirect_to root_path
    end
  end

  def show
    @reviews = @book.reviews.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.books.per_page

    if @reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating)
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "delete_successfully"
    else
      flash.now[:danger] = t "error_message"
    end
    redirect_to books_url
  end

  def update
    @book.category_id = params[:category_id]

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
      redirect_to books_path
    else
      render :new
    end
  end

  def search
    @result = Book.search_by(params[:search]).sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.books.per_page_search
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
