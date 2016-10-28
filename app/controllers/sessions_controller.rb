class SessionsController < ApplicationController
  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Login sucesfully"
        redirect_to root_path
      else
        flash.now[:error] = "Incorrect password"
        render 'new'
      end
    else
      flash.now[:error] = "User not found"
      render 'new'
    end
  end
end
