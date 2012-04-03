class AddNotInterestedToListings < ActiveRecord::Migration
  def change
    add_column :listings, :not_interested, :boolean
  end
end
