require 'spec_helper'

describe Product do
  describe "new instance" do
    let(:valid_attributes) { FactoryGirl.attributes_for(:product) }

    it "is valid with all valid attributes" do
      expect(Product.new(valid_attributes)).to be_valid
    end

    it "is invalid without width" do
      product = FactoryGirl.build(:product, width: nil)
      expect(product).not_to be_valid
    end

    it "is invalid without height" do
      product = FactoryGirl.build(:product, height: nil)
      expect(product).not_to be_valid
    end

    it "is invalid without depth" do
      product = FactoryGirl.build(:product, depth: nil)
      expect(product).not_to be_valid
    end

    it "is invalid without stock_level" do
      product = FactoryGirl.build(:product, stock_level: nil)
      expect(product).not_to be_valid
    end

    it "is invalid with width less than 1" do
      product = FactoryGirl.build(:product, width: 0)
      expect(product).not_to be_valid
    end

    it "is invalid with height less than 1" do
      product = FactoryGirl.build(:product, height: 0)
      expect(product).not_to be_valid
    end

    it "is invalid with depth less than 1" do
      product = FactoryGirl.build(:product, depth: 0)
      expect(product).not_to be_valid
    end

    it "is invalid with weight less than 1" do
      product = FactoryGirl.build(:product, weight: 0)
      expect(product).not_to be_valid
    end

    it "is invalid with stock level less than 1" do
      product = FactoryGirl.build(:product, stock_level: 0)
      expect(product).not_to be_valid
    end
  end
end
