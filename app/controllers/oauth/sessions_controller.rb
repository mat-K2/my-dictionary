class Oauth::SessionsController < ApplicationController
  skip_before_filter :simple_authenticate_user

  def create
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if authentication
      @user = authentication.user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.new(:email => "test@example.com", :password => "fewfafea")
      @user.authentication = @user.build_authentication(:provider => auth["provider"], :uid => auth[:uid])
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      end
    end
  end
end
