class CampaignsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  DEFAULT_REWARD_COUNT = 3

  def new
    @campaign = Campaign.new
    DEFAULT_REWARD_COUNT.times { @campaign.rewards.build }
  end

  def create
    @campaign = Campaign.new campaign_params
    if @campaign.save
      SendCampaignFinishReminderJob.set({wait_until: @campaign.end_date - 5.day}).perform_later(@campaign)
      redirect_to campaign_path(@campaign), notice: "Campaign created"
    else
      (DEFAULT_REWARD_COUNT - @campaign.rewards.size).times { @campaign.rewards.build }
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
    (DEFAULT_REWARD_COUNT - @campaign.rewards.size).times { @campaign.rewards.build }
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
    params.require(:campaign).permit(:title, :body, :goal, :end_date, :address,  {rewards_attributes: [:amount, :description, :id, :_destroy]})
  end

  def find_campaign
    @campaign = Campaign.find params[:id]
  end
end
