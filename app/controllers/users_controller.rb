class UsersController < ApplicationController

  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t("welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
    flash[:success] = t("profile_updated")
    redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("delete_user")
      redirect_to users_path
    else
      render file: "public/404.html", status: :not_found, layout: false
    end
  end

  def following
    @title = t(".page_title_following")
    @users = @user.following.paginate page: params[:page]
    render :show_follow
  end

  def followers
    @title = t(".page_title_followers")
    @users = @user.followers.paginate page: params[:page]
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    render file: "public/404.html", status: :not_found, layout: false
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t("please_login")
      redirect_to login_path
    end
  end

  def correct_user
    load_user
    if @user.present?
      redirect_to root_path unless current_user? @user
    else
      render file: "public/404.html", status: :not_found, layout: false
    end
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
