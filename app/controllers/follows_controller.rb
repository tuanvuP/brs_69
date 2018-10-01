class FollowsController < ApplicationController
  before_action :logged_in_user

  def create
    begin
      @user = User.find_by(id: params[:followed_id])
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    rescue
      render file: "public/404.html", status: :not_found, layout: false
    end
  end

  def destroy
    begin
      @user = Follow.find_by(id: params[:id]).followed
      current_user.unfollow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    rescue
      render file: "public/404.html", status: :not_found, layout: false
    end
  end
end
