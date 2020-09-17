class ChangeOldColumnToNewColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :name, :key
    rename_column :items, :phone, :value
  end
end
