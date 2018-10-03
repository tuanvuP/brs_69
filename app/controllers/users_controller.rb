class UsersController < ApplicationController
  before_action :correct_user, only: :edit
  before_action :load_user, only: [:show, :edit]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t("welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    render file: "public/404.html", status: :not_found, layout: false
  end

  def correct_user
    load_user

    if @user.present?
      redirect_to root_url unless current_user? @user
    else
      render file: "public/404.html", status: :not_found, layout: false
    end
  end
end
