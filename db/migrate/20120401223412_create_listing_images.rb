class CreateListingImages < ActiveRecord::Migration
  def change
    create_table :listing_images do |t|
      t.references :listing_id
      t.timestamps
    end
  end
end
