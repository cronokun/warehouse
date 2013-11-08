require 'spec_helper'

describe PackController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "assigns all boxes to @boxes" do
      box = FactoryGirl.create(:box)
      get 'new'
      expect(assigns(:boxes)).to eq [box]
    end

    it "assigns all products to @products" do
      prd_1 = FactoryGirl.create(:product)
      prd_2 = FactoryGirl.create(:product)
      get 'new'
      expect(assigns(:products)).to eq [prd_1, prd_2]
    end

    it "renders 'new' template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    let!(:box)     { FactoryGirl.create(:box)}
    let!(:product) { FactoryGirl.create(:product) } 
    let(:packer)   { double("Packer", :pack! => self, boxes: [packed_box]) }
    let(:packed_box) { double("Packer::Box") }
    let(:valid_params) do
      {
        boxes: [box.id],
        products: [{id: product.id, stock: "10"}]
      }
    end

    it "pack products" do
      Packer::Packer.should_receive(:new).with({boxes: [box.volume], products: {product => 10}}).and_return packer
      packer.should_receive(:pack!).once
      packer.should_receive(:boxes).once
      post :create, valid_params
    end

    it "assigns packed boxes to @boxes" do
      Packer::Packer.should_receive(:new).and_return packer
      post :create, valid_params
      expect(assigns(:boxes)).to eq [packed_box]
    end

    it "renders 'show' template" do
      post :create, valid_params
      expect(response).to render_template('show')
    end
  end

end
