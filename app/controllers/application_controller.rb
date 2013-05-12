class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate_user!
  before_filter :simple_authenticate_user

  def simple_authenticate_user
    unless session[:user_id]
      redirect_to new_user_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
