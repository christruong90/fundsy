class SendCampaignFinishReminderJob < ActiveJob::Base
  queue_as :default

  def perform(*campaihn)
    if campaign.pledged_amount < campaign.goal
      rails.logger.info ">>>>>> NO NEED TO SEND EMAIL TO USER"
    end
  end
end
