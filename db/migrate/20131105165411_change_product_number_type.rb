class ChangeProductNumberType < ActiveRecord::Migration
  def up
    change_column :products, :product_number, :string
  end

  def down
    change_column :products, :product_number, :integer
  end
end
