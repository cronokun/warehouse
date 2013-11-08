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

  describe "#change_volume" do
    it "changes box volume" do
      box = Packer::Box.new(1)
      expect {
        box.change_volume(5)
      }.to change(box, :volume).to(5_000_000)
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

  describe "#products_with_stock" do
    it "returns list of products with stock levels" do
      box = Packer::Box.new(1)
      small_prd = double(volume: 100)
      medium_prd = double(volume: 200)
      big_prd = double(volume: 500)

      100.times { box.add_product(small_prd) }
      200.times { box.add_product(medium_prd) }
      100.times { box.add_product(big_prd) }

      expect(box.products_with_stock).to eq({ small_prd => 100, medium_prd => 200, big_prd => 100 })
    end
  end
end
