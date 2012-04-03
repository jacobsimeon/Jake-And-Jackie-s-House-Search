require 'nokogiri'

class ResultPage
  def initialize(doc)
    @doc = doc 
  end

  def listing_details_links
    @links ||= @doc.css('a.ThumbAddress').map { |link| link['href'] }
  end
end
