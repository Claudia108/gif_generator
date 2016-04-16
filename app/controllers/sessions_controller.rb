class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      flash[:login] = "Welcome, you are logged in."
      session[:user_id] = @user.id
      redirect_to gifs_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render 'sessions/new'
    end
  end

  def destroy
    session.clear
    flash[:logout] = "You have been logged out."
    redirect_to root_path
  end

end
