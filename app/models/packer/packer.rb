module Packer
  class Packer
    attr_reader :available_box_volumes, :products_with_stock
    attr_accessor :boxes

    def initialize(attrs = {})
      @boxes = []
      @available_box_volumes = attrs.fetch(:boxes, []).sort
      @products_with_stock = attrs.fetch(:products, {})
                                  .sort_by { |prd, _| prd.volume }
    end

    def products
      @products ||= products_with_stock \
        .inject([]) { |memo, (prd, stock)| memo.push Array.new(stock, prd) }
        .flatten
    end

    def pack!
      box_volumes = available_box_volumes.each
      add_suitable_box(box_volumes.next)

      loop do
        add_products_to_box(boxes.last)
        break if products.empty?

        begin
          try_bigger_box(boxes.last, box_volumes.next)
        rescue StopIteration
          add_suitable_box(box_volumes.rewind.next)
        end
      end

      self
    end

    # prety print packed boxes for better debugging
    def pp
      products_total_volume = products_with_stock.inject(0) { |sum, (prd, stock)| sum += prd.volume * stock } / 1_000_000

      puts "Put #{products_total_volume} L of products in #{available_box_volumes.join(', ')} L  boxes:"
      boxes.each_with_index do |box, i|
        puts "#{i+1}:  #{box.total_volume / 1_000_000} of #{box.volume_in_liters}"
      end
      puts
    end

    private

    def add_products_to_box(box)
      loop do
        if products.present? and box.add_product(products.first)
          products.shift
        else
          break
        end
      end
    end

    def add_suitable_box(volume)
      @boxes.push ::Packer::Box.new(volume)
    end

    def try_bigger_box(smaller_box, new_volume)
      box = ::Packer::Box.new(new_volume)
      smaller_box.move_products_to(box)
      boxes.delete(smaller_box)
      boxes.push(box)
    end
  end
end
