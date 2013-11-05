class AddIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :product_number
  end
end
