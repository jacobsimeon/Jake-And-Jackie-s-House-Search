
require 'bundler/setup'
require 'yaml'
require 'scrapers/searcher.rb'
require 'scrapers/listing_page_scraper.rb'

namespace :mls do

  task :search do

    require 'selenium/client'
    require 'nokogiri'
    require 'scrapers/result_page'

    links = Searcher.new.run_search
    File.open('./lib/assets/search_results.yml', 'w+') { |f| f.write YAML.dump(links) }
    
  end

  task :scrape_results => :environment do
    urls = YAML.load File.read('./lib/assets/search_results.yml')
    scraper = ListingPageScraper.new urls
    scraper.scrape_pages
  end

  task :map_urls => :environment do 
    urls = YAML.load File.read('./lib/assets/search_results.yml')
    root = "http://www.intermountainmls.com/Listings/"

    Listing.all.each do |listing|
      puts "finding url for listing ##{listing.mls_number}"
      match = urls.select { |url| url =~ /l=#{listing.mls_number}&/ }.first rescue ""
      match = root + match
      listing.url = match
      puts "found url #{listing.url}"
      listing.save
    end
  end

  task :set_defaults => :environment do
    Listing.all.each do |listing|
      listing.interested = false
      listing.not_interested = false
      listing.save
    end
  end

  task :import do
    Rake::Task["mls:scrape_results"].invoke
  end

end

