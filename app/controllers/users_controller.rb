class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:create] = "Success! Your account has been created."
      redirect_to gifs_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
