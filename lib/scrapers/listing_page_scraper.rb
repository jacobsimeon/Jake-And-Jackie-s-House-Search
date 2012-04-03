require 'open-uri'
require 'scrapers/listing_page'

class ListingPageScraper

  def initialize(urls)
    @root = "http://www.intermountainmls.com/Listings/"
    @urls = urls.map { |url| @root + url }
  end

  def load_page uri
    open uri
  end

  def scrape_pages
    @urls.each do |uri|
      puts "scraping #{uri}"
      listing = ListingPage.new open(uri), uri
      save_listing(listing, uri) unless listing.short_sale?
    end
  end

  def save_listing(scraped_listing, url)
    @listing = Listing.where(:mls_number => scraped_listing.mls_number)
    if @listing.any?
      @listing = @listing.first
      @listing.update_attributes scraped_listing.attributes
    else
      @listing = Listing.create scraped_listing.attributes
      scraped_listing.image_paths.each do |image_path|
        full_path = @root + image_path
        puts "attaching image: #{full_path}"
        listing_image = ListingImage.new
        file = open full_path 
        puts file.size
        listing_image.image = file
        listing_image.listing = @listing
        listing_image.save
      end
    end
    @listing.save
    @listing
  end

end
