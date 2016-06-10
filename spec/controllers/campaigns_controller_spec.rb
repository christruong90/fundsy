require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      # this mimicks a `GET` request to the `new` action in the CampaignsController
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new campaign instance variable" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, campaign: {title: "Hello World", body: "abc", goal: 15}
      end

      it "saves a record to the database" do
        count_before = Campaign.count
        valid_request
        count_after  = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the show page of the campaign" do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, campaign: {title: ""}
      end

      it "doesn't save a record to the database" do
        count_before = Campaign.count
        invalid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
