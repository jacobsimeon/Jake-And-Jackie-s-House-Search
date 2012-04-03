class AddDefaultValuesToListings < ActiveRecord::Migration
  def change
    change_column :listings, :not_interested, :boolean, :default => false, :null => false
    change_column :listings, :interested, :boolean, :default => false, :null => false
  end
end
