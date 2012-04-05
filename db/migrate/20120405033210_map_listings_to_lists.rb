class MapListingsToLists < ActiveRecord::Migration
  def up
    change_table :listings do |t|
      t.references :list
    end

    interested = List.create :name => "interested", :description => "A list of houses we're interested in"
    not_interested = List.create :name => "not_interested", :description => "Houses we've decided we aren't interested in" 
    undecided = List.create :name => "undecided", :description => "Houses we haven't considered yet"

    Listing.where(:interested => true).find_each do |listing|
      listing.list = interested
      listing.save
    end

    Listing.where(:not_interested => true).find_each do |listing|
      listing.list = not_interested
      listing.save
    end

    Listing.where(:not_interested => false, :interested => false) do |listing|
      listing.list = undecided
      listing.save
    end

    change_table :listings do |t|
      t.remove :not_interested
      t.remove :interested
    end
  end


  def down
  end
end
