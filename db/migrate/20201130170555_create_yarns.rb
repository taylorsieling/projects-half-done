class CreateYarns < ActiveRecord::Migration
  def change
    create_table :yarns do |t|
      t.string :name
      t.integer :weight
      t.string :color
      t.integer :quantity
      t.integer :project_id
      t.timestamps null: false
    end
  end
end
