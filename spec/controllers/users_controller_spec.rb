require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    before { get :new }

    it { expect(response).to render_template(:new) }
    # it "renders the new template" do
    #   expect(response).to render_template(:new)
    # end

    it { expect(assigns(:user)).to be_a_new(User) }
    # it "sets a new User instance variable" do
    #   expect(assigns(:user)).to be_a_new(User)
    # end

  end
  
  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, user: attributes_for(:user)
      end

      it "creates a user record in the database" do
        # expect { valid_request }.to change { User.count }.by(1)
        count_before = User.count
        valid_request
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the home page" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "sets a session's user_id to the created user id" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, user: {first_name: ""}
      end
      it "doesn't create a user record in the database" do
        count_before = User.count
        invalid_request
        count_after  = User.count
        expect(count_after).to eq(count_before)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
