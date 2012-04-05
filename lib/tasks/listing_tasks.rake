namespace :listings do
  task :map_lists => :environment do
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
  end
end
