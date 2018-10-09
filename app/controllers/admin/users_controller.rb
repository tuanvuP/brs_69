class Admin::UsersController < ApplicationController
  layout "admin_layout"

  def index
    @users = User.all
  end
end
