class AddListingHtmlColumn < ActiveRecord::Migration
  def up
    add_column :listings, :html, :text
  end

  def down
    remove_column :listings, :html
  end
end
