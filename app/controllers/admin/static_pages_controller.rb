class Admin::StaticPagesController < ApplicationController
  layout "admin_layout"

  def index
    if !current_user.admin?
      flash[:danger] = t "deny_access"
      redirect_to books_path
    end
  end
end
