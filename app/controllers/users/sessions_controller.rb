class Users::SessionsController < Devise::SessionsController
  skip_before_filter :simple_authenticate_user

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end
end
