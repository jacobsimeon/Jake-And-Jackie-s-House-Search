class AddMlsNumberIndex < ActiveRecord::Migration
  def up
    add_index :listings, :mls_number, :unique => true
  end

  def down
  end
end
