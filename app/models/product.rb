class Product < ActiveRecord::Base
  validates :width, :height, :depth, :weight, :stock_level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
