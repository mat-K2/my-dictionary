class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate_user!

  def current_user
    current_user = User.find_by_email("yamada@test.com")
  end
end
