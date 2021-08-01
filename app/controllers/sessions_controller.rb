class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :redirect_if_logged_in, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Unable to login. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end