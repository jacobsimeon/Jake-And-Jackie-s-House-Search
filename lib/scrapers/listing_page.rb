require 'bundler/setup'
require 'nokogiri'

class ListingPage
  attr_accessor :document
  attr_accessor :url
  attr_accessor :html

  def initialize(html, url="")
    @html = html.read
    @document = Nokogiri::HTML(@html)
    @url = url
  end

  def short_sale?
    short_sale = false
    @document.css('td.DetailsR').each do |table|
      text_value = table.content.match(/Possible Short Sale:.(.*)/).captures[0]
      short_sale = text_value == "Yes"
    end
    short_sale
  end

  def mls_number
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblMLSNum"
  end

  def street_address 
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblAddr"    
  end

  def city
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblCity"
  end

  def state
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblState"
  end

  def zip
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblZip"
  end

  def price
    get_span_content "ctl00_ContentPlaceHolder1_ucDets_lblAskPrice"
  end

  def image_paths
    @document.css('ul.rrItemsList img').map do |img|
      img[:src]
    end
  end

  def attributes
    {
      short_sale: short_sale?,
      mls_number: mls_number,
      street_address: street_address,
      city: city,
      state: state,
      zip: zip,
      price: price,
      html: html,
      url: url
    }
  end

  private
  def get_span_content span_id
    content = ""
    @document.css("span#" + span_id).each do |span|
      content = span.content
    end
    content
  end

end
