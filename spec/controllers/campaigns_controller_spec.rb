require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  let(:campaign) { FactoryGirl.create(:campaign) }
  # def campaign
  #   @campaign ||= FactoryGirl.create(:campaign)
  # end

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
        post :create, campaign: FactoryGirl.attributes_for(:campaign)
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

  describe "#show" do
    # the `before` defines a block that gets executed before every example
    before do
      get :show, id: campaign.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets an instance variable to the campaign with the passed id" do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets `campaigns` instance variable to all campaigns in the DB" do
      campaign_1 = FactoryGirl.create(:campaign)
      campaign_2 = FactoryGirl.create(:campaign)
      get :index
      expect(assigns(:campaigns)).to eq([campaign_1, campaign_2])
    end
  end

  describe "#edit" do
    before do
      get :edit, id: campaign.id
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "set an instance variable to the campaign with the id passed" do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#update" do
    context "With valid attributes" do
      def valid_request
        patch :update, id: campaign.id, campaign: {title: "new valid title"}
      end
      it "updates the record in the database" do
        valid_request
        expect(campaign.reload.title).to eq("new valid title")
      end

      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(campaign))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      def invalid_request
        patch :update, id: campaign.id, campaign: {title: ""}
      end
      it "doesn't save the new value to the database" do
        invalid_request
        expect(campaign.reload.title).to_not eq("")
      end

      it "renders the edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    # using `let!` forces the block to be executed before every test example
    # regardless whether you call the method or not.
    let!(:campaign) { FactoryGirl.create(:campaign) }

    it "removes the record from the database" do
      count_before = Campaign.count
      delete :destroy, id: campaign.id
      count_after  = Campaign.count
      expect(count_before).to eq(count_after + 1)
    end

    it "redirects to campaigns_path (listings page)" do
      delete :destroy, id: campaign.id
      expect(response).to redirect_to(campaigns_path)
    end
  end

end
