class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, except: [:edit, :update, :show]
  before_action :set_user, only: [:show, :edit, :update]

  # Users can create accounts and view + edit their account details
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Unable to create account. Please try again."
      redirect_to signup_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end