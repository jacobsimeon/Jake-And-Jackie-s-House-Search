class AddUrlToListign < ActiveRecord::Migration
  def change
    add_column :listings, :url, :string
  end
end
