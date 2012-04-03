class FixListingIdReference < ActiveRecord::Migration
  def up
    rename_column :listing_images, :listing_id_id, :listing_id
  end

  def down
    rename_column :listing_images, :listing_id, :listing_id_id
  end
end
