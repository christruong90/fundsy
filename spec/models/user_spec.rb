require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires a first name" do
      # u = FactoryGirl.attributes_for(:user).merge({first_name: nil})
      u = build(:user, {first_name: nil})
      u.valid?
      # expect(u).to be_invlid
      expect(u.errors).to have_key(:first_name)
    end

    it "requires a last name" do
      u = build(:user, {last_name: nil})
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end

    it "requires a valid email" do
      u = build(:user, {email: "i'm an invalid email"})
      u.valid?
      expect(u.errors).to have_key(:email)
    end

    it "requires the email to be unique" do
      create(:user, email: "tam@codecore.ca")
      u = build(:user, email: "tam@codecore.ca")
      u.valid?
      expect(u.errors).to have_key(:email)
    end
  end
end
