class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :product_number
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :depth
      t.integer :weight
      t.integer :stock_level

      t.timestamps
    end
  end
end
