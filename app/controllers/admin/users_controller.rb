class Admin::UsersController < ApplicationController
  layout "admin_layout"

  before_action :load_user, only: [:edit, :update, :destroy]

  def edit; end

  def index
    @users = User.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.admin.users.per_page
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_successfully"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete_successfully"
    else
      flash[:danger] = t "error_message"
    end
    redirect_to admin_users_path
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
end
