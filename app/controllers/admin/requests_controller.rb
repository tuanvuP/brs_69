class Admin::RequestsController < ApplicationController
  layout "admin_layout"

  def index
    @requests = Request.all
  end
end
