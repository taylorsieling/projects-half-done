class AddUserIdToYarns < ActiveRecord::Migration
  def change
    add_column :yarns, :user_id, :integer
  end
end
