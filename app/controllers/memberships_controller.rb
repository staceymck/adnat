class MembershipsController < ApplicationController
  before_action :set_user
  before_action :set_organisation, only: [:destroy]
  
  # Join an organisation
  def create
    if @user.update(membership_params)
      redirect_to dashboard_path
    else
      render 'dashboard/show' #how to render error messages? - errors on user?
    end
  end

  # Leave an organisation
  def destroy
    @organisation.users.delete(@user)
    @user.shifts.delete_all(:delete_all)
    redirect_to dashboard_path
  end

  private
  def membership_params
    params.require(:membership).permit(:organisation_id)
  end

  def set_user
    @user = current_user
  end

  def set_organisation
    @organisation = Organisation.find(membership_params[:organisation_id])
  end
end