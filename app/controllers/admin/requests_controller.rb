class Admin::RequestsController < ApplicationController
  layout "admin_layout"

  before_action :load_request, only: [:edit, :update, :destroy]

  def edit; end

  def index
    @requests = Request.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.controllers.admin.requests.per_page
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "update_successfully"
      redirect_to admin_requests_path
    else
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "delete_successfully"
    else
      flash[:danger] = t "error_message"
    end
    redirect_to admin_requests_path
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
