class ShiftsController < ApplicationController
  before_action :set_user, only: [:new, :create]
  before_action :set_shift, only: [:edit, :update, :destroy]
  before_action :set_organisation, :redirect_if_not_authorized, only: [:index, :edit, :update, :destroy]

  # Index only used for nested route - organisation/:id/shifts
  def index
    org_id = params[:organisation_id]
    @shifts = Shift.includes(:user).where(users: {organisation_id: org_id}).newest
    if params[:q]
      @shifts = @shifts.filter_by_user_name(params[:q])
    end
  end

  # Only allow users who have an org to add a shift
  def new
    if @user.organisation
      @shift = Shift.new
    else
      redirect_to dashboard_path
    end
  end

  # Only allow users who have an org to add a shift
  def create
    if @user.organisation
      @shift = @user.shifts.build(shift_params)
      if @shift.save
        redirect_to organisation_shifts_path(@user.organisation)
      else
        render :new
      end
    else
      redirect_to dashboard_path
    end
  end

  def edit
  end

  # Only allow users to edit shifts at their org
  def update
    if @shift.update(shift_params)
      redirect_to organisation_shifts_path(@organisation)
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
    redirect_to organisation_shifts_path(@organisation)
  end

  private
  def shift_params
    params.require(:shift).permit(:date, :start_time, :finish_time, :break_length)
  end

  def set_user
    @user = current_user
  end

  def set_shift
    @shift = Shift.find_by_id(params[:id])
  end

  def redirect_if_not_authorized
    # Make sure current user is a member of the organisation where shift took place
    if !@organisation || current_user.organisation_id != @organisation.id
      flash[:alert] = "Invalid path"
      redirect_to dashboard_path
    end
  end

  def set_organisation
    # If accessing via nested route (shifts index view), verify org based on id in route params
    if params[:organisation_id]
      @organisation = Organisation.find_by_id(params[:organisation_id])
    else
      @organisation = @shift.user.organisation
    end
  end
end