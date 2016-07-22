class NearbyCampaignsController < ApplicationController
  def index
    @campaigns = Campaign.near("Vancouver, BC", 5, units: :km)
    @markers_hash = Gmaps4rails.build_markers(@campaigns) do |campaign, marker|
                      marker.lat campaign.latitude
                      marker.lng campaign.longitude
                      marker.infowindow campaign.title
                    end
  end
end
