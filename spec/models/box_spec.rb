require 'spec_helper'

describe Box do
  describe "new instance" do
    it "is valid with all valid attributes" do
      valid_attributes = FactoryGirl.attributes_for(:box)
      expect(Box.new(valid_attributes)).to be_valid
    end
    
    it "is invalid without name" do
      expect(FactoryGirl.build(:box, name: nil)).not_to be_valid
    end

    it "is invalid without volume" do
      expect(FactoryGirl.build(:box, volume: nil)).not_to be_valid
    end

    it "is invalid with volume less than 1" do
      expect(FactoryGirl.build(:box, volume: 0)).not_to be_valid
    end
  end
end
