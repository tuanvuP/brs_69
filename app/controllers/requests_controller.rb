class RequestsController < ApplicationController
  before_action :load_request, only: [:edit, :update, :destroy]

  def index
    if logged_in?
      if current_user.admin?
        @requests = Request.sort_by_created_desc.paginate page: params[:page]
      else
        @requests = current_user.requests.sort_by_created_desc.paginate page: params[:page]
      end
    else
      flash[:danger] = t "please_login"
      redirect_to login_path
    end

    @request = Request.new
  end

  def new
    if logged_in?
      if current_user.admin?
        flash[:danger] = t "logged_in_as_admin"
        redirect_to requests_path
      else
        @request = Request.new
      end
    else
      flash[:danger] = t "please_login"
      redirect_to login_path
    end
  end

  def create
    @request = current_user.requests.build request_params

    if @request.save
      flash[:success] = t "create_successfully"
      redirect_to requests_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "update_successfully"
      redirect_to requests_path
    else
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "delete_successfully"
    else
      flash.now[:danger] = t "error_message"
    end
    redirect_to requests_path
  end

  private

  def request_params
    params.require(:request).permit :user_id, :content, :title
  end

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    render file: "public/404.html", status: :not_found, layout: false
  end
end
