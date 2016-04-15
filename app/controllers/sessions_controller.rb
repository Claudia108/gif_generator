class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:sessions_username])
    if @user && @user.authenticate(params[:session][:sessions_password])
      session[:user_id] = @user.id
      redirect_to gifs_path
    else
      flash.now[:error] = "Invalid. Try Again."
      render 'sessions/new'
    end
  end

end
