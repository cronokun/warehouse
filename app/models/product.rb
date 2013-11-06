class Product < ActiveRecord::Base
  validates :name, presence: true

  validates :product_number,
    presence: true, uniqueness: true

  validates :width, :height, :depth, :weight, :stock_level,
    presence: true, numericality: { only_integer: true, greater_than: 0 }

  # product volume in cubic millimeters
  def volume
    width * height * depth
  end
end
