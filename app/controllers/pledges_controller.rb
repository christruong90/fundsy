class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign        = Campaign.find params[:campaign_id]
    pledge_params   = params.require(:pledge).permit(:amount)
    pledge          = Pledge.new pledge_params
    pledge.campaign = campaign
    pledge.user     = current_user
    pledge.save
    redirect_to campaign_path(params[:campaign_id])
  end

end
