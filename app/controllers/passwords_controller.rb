class PasswordsController < ApplicationController
  skip_before_action :require_login
  def forgot
    render "forgot"
  end
  
  def reset
    flash[:alert] = "If account exists, we have sent you an email to reset your password"
    redirect_to forgot_path
  end
end