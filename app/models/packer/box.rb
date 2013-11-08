module Packer
  class Box
    attr_reader :volume, :products

    def initialize(volume_in_liters)
      @products = []
      @volume = volume_in_liters * 1_000_000
    end

    def volume_in_liters
      volume / 1_000_000
    end

    def add_product(product)
      products.push product if product.volume + total_volume <= volume
    end

    def change_volume(new_volume)
      @volume = new_volume * 1_000_000
    end

    def total_volume
      products.inject(0) { |sum, prd| sum += prd.volume }
    end

    def products_with_stock
      Hash.new.tap do |hash|
        products.uniq.each { |prd| hash[prd] = products.count(prd) }
      end
    end
  end
end
