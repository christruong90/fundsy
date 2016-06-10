require 'rails_helper'

RSpec.describe Campaign, type: :model do

  describe "validations" do
    it "requires a title" do
      # Given: campaign record with no title
      c = Campaign.new

      # When: invoke validations
      result = c.valid?

      # Then: expect the outcome to be false
      # expect(result).to eq(false)
      expect(c.errors).to have_key(:title)
    end

    it "requires a body" do
      c = Campaign.new
      c.valid?
      expect(c.errors).to have_key(:body)
    end

    it "requires a unique title" do
      # Given: A campaign created in the Database with some title
      Campaign.create(title: "abc", body: "1234", goal: 25)

      # When: New campaign being created with the same title
      c = Campaign.new(title: "abc")
      c.valid?

      # Then: There is an errror on the title field
      expect(c.errors).to have_key(:title)
    end

    it "requires a goal that is $10 or more" do
      c = Campaign.new goal: 7
      c.valid?
      expect(c.errors).to have_key(:goal)
    end
  end

  describe ".upcased_title" do
    it "returns an upcased version of the campaign's title" do
      c = Campaign.new title: "abc"
      expect(c.upcased_title).to eq("ABC")
    end
  end

end
