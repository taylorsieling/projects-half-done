class AddBrandToYarns < ActiveRecord::Migration
  def change
    add_column :yarns, :brand, :string
  end
end
