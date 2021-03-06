class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper
  protect_from_forgery with: :exception
  helper_method :current_user

  def require_login
     unless current_user.present?
       flash[:error] = 'You must login'
       redirect_to login_path
     end
   end

  protected
  def current_user
    return @current_user if @current_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end

end
