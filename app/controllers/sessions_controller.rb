class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      flash[:login] = "Welcome, you are logged in."
      session[:user_id] = @user.id


      if @user.admin?
        flash[:login] = "Welcome, you are logged in as an admin."
        redirect_to admin_categories_path
      else
        redirect_to gifs_path
      end
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
