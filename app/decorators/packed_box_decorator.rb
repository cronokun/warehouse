class PackedBoxDecorator < Draper::Decorator
  delegate_all

  def filled_volume
    h.content_tag(:strong, "box filled #{ object.filled_volume / 1_000_000.0 } of #{ volume_in_liters } liters:")
  end

  def list_of_products
    products = products_with_stock.map do |product, stock|
      h.content_tag(:li, "#{stock}&nbsp;&times;&nbsp;#{product.name}".html_safe)
    end
    h.content_tag(:ul, h.safe_join(products), class: "list-unstyled")
  end

end
