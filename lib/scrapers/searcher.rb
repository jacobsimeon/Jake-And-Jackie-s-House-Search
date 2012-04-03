require 'selenium/client'
require 'nokogiri'
require 'scrapers/result_page'

class Searcher
  attr_accessor :listing_urls
  attr_accessor :links

  def initialize
    @pages = []
    @pager_links = []
    @browser = Selenium::Client::Driver.new({
      :host => "localhost",
      :port => 4444, 
      :browser => "*firefox", 
      :url => "http://www.intermountainmls.com", 
      :timeout_in_second => 60
    })
    @browser.start_new_browser_session
  end

  def run_search
    open_search_page
    populate_form
    submit_search
    add_current_page
    add_paginated_results
    parse_listing_links
    close_browser
    puts "found #{@links.count} results"
    @links
  end

  private
  def open_search_page
    @browser.open "/Listings/AdvancedSearchListings.aspx"
  end

  def close_browser
    @browser.close_current_browser_session
  end
    
  def populate_form
    @browser.check 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_location_cblCities_10' 
    @browser.check 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_location_cblCities_100'
    @browser.check 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_location_cblCities_66'
    @browser.check 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_cblPropertyType_0'
    @browser.select 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_ddlBeds', '3+'
    @browser.select 'ctl00_ContentPlaceHolder1_ucAdvanced_ucRes_ddlBaths', '2+'
    @browser.type 'ctl00$ContentPlaceHolder1$ucAdvanced$ucRes$txtMinPrice', '120000'
    @browser.type 'ctl00$ContentPlaceHolder1$ucAdvanced$ucRes$txtMaxPrice', '150000'
  end

  def submit_search
    @browser.click 'ctl00_ContentPlaceHolder1_ucAdvanced_lnkSearch', :wait_for => :page
  end

  def add_current_page
    @pages <<  Nokogiri::HTML(@browser.get_html_source)
  end

  def get_number_of_pages 
    @num_pages ||= @pages[0].css('td.gridPagerLinks a').count
  end

  def wait_for_new_results
    results_table_id = "ctl00_ContentPlaceHolder1_dlResults"
    current_results_text = @browser.text_content results_table_id
    @browser.wait_for :no_text => current_results_text, :element => results_table_id, :timeout_in_seconds => 5
  end


  def add_paginated_results
    get_number_of_pages
    link = "ctl00_ContentPlaceHolder1_ucPager_btnForward"

    (1..@num_pages).each do |i|
      @browser.set_speed 2500
      @browser.click link, :wait_for => :ajax
      add_current_page
      @browser.set_speed 0
    end

  end

  def parse_listing_links 
    @links = @pages.map do |page|
      result_page = ResultPage.new(page)
      result_page.listing_details_links 
    end.flatten
  end

end
