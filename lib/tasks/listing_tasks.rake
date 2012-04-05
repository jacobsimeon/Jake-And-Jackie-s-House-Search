namespace :listings do
  task :map_lists => :environment do
    undecided = List.find_by_name :undecided
    Listing.where(:list_id => nil).find_each do |listing|
      listing.list =  undecided
      listing.save
    end
  end
end
