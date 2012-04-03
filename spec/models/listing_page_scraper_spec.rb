require 'spec_helper.rb'
describe ListingPageScraper do

  it 'modifies an existing listing' do
    @existing_listing  = FactoryGirl.create :listing
    @page = ListingPage.new File.read('spec/example_listing_page.html')
    @existing_listing.mls_number = @page.mls_number
    @existing_listing.save
    @page_scraper = ListingPageScraper.new [] 
    @modified_listing = @page_scraper.save_listing(@page, "http://example.com")
    @modified_listing.should == @existing_listing
  end

  it 'creates a new listing if one does not already exist' do
    @page = ListingPage.new File.read('spec/example_listing_page.html')
    @existing = Listing.where(:mls_number => @page.mls_number).each do |listing|
      listing.destroy
    end
    @page_scraper = ListingPageScraper.new [] 
    @new_listing = @page_scraper.save_listing(@page, "http://example.com")

    Listing.where(:mls_number => @page.mls_number).count.should == 1
  end
  
end
