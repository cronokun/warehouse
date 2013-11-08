module Packer
  class Box
    attr_reader :volume, :products, :filled_volume

    def initialize(volume_in_liters)
      @products = []
      @filled_volume = 0
      @volume = volume_in_liters * 1_000_000
    end

    def volume_in_liters
      volume / 1_000_000
    end

    def add_product(product)
      if product.volume + filled_volume <= volume
        products.push product
        @filled_volume = filled_volume + product.volume
      end
    end

    def change_volume(new_volume)
      @volume = new_volume * 1_000_000
    end

    def products_with_stock
      Hash.new.tap do |hash|
        products.uniq.each { |prd| hash[prd] = products.count(prd) }
      end
    end
  end
end
