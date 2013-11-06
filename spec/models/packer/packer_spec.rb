require 'spec_helper'

describe Packer::Packer do
  let(:small_box)  { FactoryGirl.build(:box, volume: 1) }
  let(:medium_box) { FactoryGirl.build(:box, volume: 3) }
  let(:big_box)    { FactoryGirl.build(:box, volume: 5) }

  let(:small_prd)  { double("small product", volume: 100_000) }
  let(:medium_prd) { double("small product", volume: 300_000) }
  let(:big_prd)    { double("small product", volume: 500_000) }

  describe ".initialize" do
    it "assigns types of boxes to @available_box_volumes" do
      packer = Packer::Packer.new(boxes: [small_box])
      expect(packer.available_box_volumes).to eq [small_box]
    end

    it "assigns list of products to @products_with_stock" do
      packer = Packer::Packer.new(products: {small_prd => 10})
      expect(packer.products_with_stock).to eq([[small_prd, 10]])
    end

    it "assigns empty list to @boxes" do
      packer = Packer::Packer.new
      expect(packer.boxes).to eq []
    end
  end

  describe "#products" do
    it "returns list of all products needed to be packed" do
      packer = Packer::Packer.new(products: {small_prd => 5, medium_prd => 3, big_prd => 1})
      expect(packer.products.size).to eq 9
    end
  end

  describe "#pack!" do
    context "with single box type" do
      it "packs all products in a sinle box when it can" do
        packer = Packer::Packer.new(
          boxes: [small_box.volume],
          products: {small_prd => 10}
        ).pack!

        expect(packer.boxes.size).to eq 1
        expect(packer.boxes[0].products.size).to eq 10
      end

      it "splits products into several boxes" do
        packer = Packer::Packer.new(
          boxes: [small_box.volume],
          products: {small_prd => 18}
        ).pack!

        expect(packer.boxes.size).to eq 2
        expect(packer.boxes[0].products.size).to eq 10
        expect(packer.boxes[1].products.size).to eq 8
      end
    end

    context "with several box types" do
      it "packs products in single box with least suitable volume" do
        packer = Packer::Packer.new(
          boxes: [big_box, small_box, medium_box].map(&:volume),
          products: {small_prd => 25}
        ).pack!

        expect(packer.boxes.size).to eq 1
        expect(packer.boxes[0].products.size).to eq 25
        expect(packer.boxes[0].volume_in_liters).to eq 3
      end

      it "packs products in least number of suitable boxes" do
        packer = Packer::Packer.new(
          boxes: [big_box, small_box, medium_box].map(&:volume),
          products: { small_prd => 70 }
        ).pack!

        expect(packer.boxes.size).to eq 2
        expect(packer.boxes[0].volume_in_liters).to eq 5
        expect(packer.boxes[1].volume_in_liters).to eq 3
      end
    end

    context "with several products" do
    end

    context "debugging" do
      xit "should pass" do
        10.step(200, 10) do |vol|
        Packer::Packer.new(
          boxes: [1,2,3,5,10],
          products: { small_prd => vol }
        ).pack!.pp
        end
      end
    end

  end
end
