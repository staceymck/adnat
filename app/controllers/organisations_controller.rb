class OrganisationsController < ApplicationController
  before_action :set_organisation, except: [:create]
  
  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      redirect_to dashboard_path
    else
      @organisations = Organisation.all # Provide variables expected by template
      @user = current_user
      render template: "dashboard/non_member_show" # Only non-members can create a new org
    end
  end

  def edit
  end

  def update
    if @organisation.update(organisation_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to dashboard_path
  end

  private
  def organisation_params
    params.require(:organisation).permit(:name, :hourly_rate)
  end

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end
end