class PackController < ApplicationController
  def new
    @boxes = Box.all
    @products = Product.all
  end

  def create
    packer = ::Packer::Packer.new(
      boxes: box_volumes,
      products: products_with_stock
    )

    packer.pack!
    
    @boxes = packer.boxes
    render 'show'
  end

  private

  def box_volumes
    Box.find(box_params).map(&:volume)
  end

  def products_with_stock
    Hash.new.tap do |hash|
      products_params.each do |data|
        hash[Product.find(data[:id])] = data[:stock].to_i
      end
    end
  end

  def box_params
    params[:boxes]
  end

  def products_params
    params[:products]
  end
end
