require 'rails_helper'

RSpec.describe PledgesController, type: :controller do
  let(:campaign) { create(:campaign) }
  let(:user)     { create(:user) }

  describe "#create" do
    context "with user not signed in" do
      it "redirects to new user page" do
        post :create, campaign_id: campaign.id, pledge: {amount: 5}
        expect(response).to redirect_to(new_user_path)
      end
    end
    context "with user signed in" do
      before { request.session[:user_id] = user.id }

      context "with valid attributes" do
        def valid_request
          post :create, campaign_id: campaign.id, pledge: {amount: 5}
        end
        it "creates the pledge in the database" do
          expect { valid_request }.to change { Pledge.count }.by(1)
        end

        it "redirect to the campaign show page" do
          valid_request
          expect(response).to redirect_to campaign_path(campaign)
        end

        it "associates the pledge with the campaign" do
          valid_request
          expect(Pledge.last.campaign).to eq(campaign)
        end

        it "associates the pledge with the logged in user" do
          valid_request
          expect(Pledge.last.user).to eq(user)
        end
      end
      context "with invalid attributes" do
        it "doesn't create a pledge in the database"
        it "renders the campaign show page"
      end
    end
  end
end
