class CategoriesController < ApplicationController
  before_action :load_categories, except: [:index, :show, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.parent_id = params[:parent_id]

    if @category.save
      flash[:success] = t "create_successfully"
      redirect_to categories_path
    else
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def load_categories
    @categories = Category.all.map{ |m| [m.name, m.id] }
  end
end
