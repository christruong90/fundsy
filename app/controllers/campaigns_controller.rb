class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new campaign_params
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created"
    else
      flash[:alert] = "Campaign not saved"
      render :new
    end
  end

  def show
  end

  def index
    @campaigns = Campaign.order(:created_at)
  end

  def edit
  end

  def update
    if @campaign.update campaign_params
      # flash[:notice] = "update successful"
      redirect_to campaign_path(@campaign), notice: "update successful"
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :body, :goal, :end_date)
  end

  def find_campaign
    @campaign = Campaign.find params[:id]
  end
end
