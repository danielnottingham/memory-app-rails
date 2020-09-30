class AddVisibleFieldToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :visible, :boolean
  end
end
