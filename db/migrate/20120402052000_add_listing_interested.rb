class AddListingInterested < ActiveRecord::Migration
  def up
    add_column :listings, :interested, :boolean
  end

  def down
  end
end
