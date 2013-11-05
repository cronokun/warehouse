require 'spec_helper'

describe ProductDecorator do
  describe "#dimension" do
    let(:product) { FactoryGirl.build(:product, width: 100, height: 50, depth: 35) }
    let(:decorator) { ProductDecorator.new(product) }

    it "returns string with all dimensions" do
      expect(decorator.dimension).to eq "100x50x35"
    end

    it "uses custom separator if specified" do
      expect(decorator.dimension(" by ")).to eq "100 by 50 by 35"
    end
  end
end
