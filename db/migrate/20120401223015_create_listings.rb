class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.boolean :short_sale
      t.string :mls_number
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :price

      t.timestamps
    end
  end
end
