class DashboardController < ApplicationController
  def show
    @user = current_user
    
    if @user.organisation
      @organisation = @user.organisation
      render 'member_show'
    else
      @organisations = Organisation.all
      render 'non_member_show'
    end
  end
end