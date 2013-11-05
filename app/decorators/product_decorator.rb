class ProductDecorator < Draper::Decorator
  delegate_all

  def dimension(separator = "x")
    [width, height, depth].join(separator)
  end
end
