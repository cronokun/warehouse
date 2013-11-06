require 'spec_helper'

describe Packer::Box do
  describe ".initialize" do
    it "assigns @products with empty list" do
      expect(Packer::Box.new(1).products).to eq []
    end

    it "assigns box volume to @volume" do
      expect(Packer::Box.new(1).volume).to eq be_present
    end

    it "recalculates volume from liters to cubic millimetes" do
      expect(Packer::Box.new(3).volume).to eq 3_000_000
    end
  end

  describe "volume_in_liters" do
    it "returns box volume in liters" do
      expect(Packer::Box.new(5).volume_in_liters).to eq 5
    end
  end

  describe "#add_products" do
    let(:box) { Packer::Box.new(1) } 

    it "puts products to the box" do
      expect {
        box.add_product double(volume: 1_000)
      }.to change(box.products, :size)
    end

    it "returns nil when there is no room in the box" do
      expect {
        box.add_product double(volume: 2_000_000)
      }.not_to change(box.products, :size)
    end
  end

  describe "#total_volume" do
    it "returns total volume of all products stored in the box" do
      box = Packer::Box.new(1)
      box.add_product double(volume: 1_000)
      box.add_product double(volume: 2_000)
      box.add_product double(volume: 3_000)

      expect(box.total_volume).to eq 6_000
    end
  end
end
