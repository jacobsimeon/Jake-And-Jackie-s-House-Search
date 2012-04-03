require 'spec_helper'

describe ListingPage do
  before do
    @html = File.read 'spec/example_listing_page.html'
    @listing = ListingPage.new @html
  end

  describe '#initialize' do
    it 'creates a nokogiri document' do
      @listing.document.should be_a(Nokogiri::HTML::Document)
    end
  end

  it 'determines whether or not the listing is a short sale' do
    @listing.should be_short_sale
  end
  it 'determins the mls number' do
    @listing.mls_number.should == "98476490"
  end
  it 'determines the street address' do
    @listing.street_address.should == "2732 N Dayside"
  end
  it 'determines the city' do
    @listing.city.should == "Meridian"
  end
  it 'determines the state' do
    @listing.state.should == "ID"
  end
  it 'determines the zip code' do
    @listing.zip.should == "83642"
  end
  it 'determines the price' do
    @listing.price.should == "120,000"
  end
  it 'builds an array of image paths' do
    expected_paths = [
      "../GetImage.aspx?i=l-t_98476490_A-46C68905F610483DE69FB2229FA69891A509AFD4",
      "../GetImage.aspx?i=l-t_98476490_B-C870EB04B64C81B422280B2A095D17B644E510D1",
      "../GetImage.aspx?i=l-t_98476490_C-DA1371C0DF9B3D6F2586F19C3A72059DE5EF6882",
      "../GetImage.aspx?i=l-t_98476490_D-2E2083D2FBFE06E1143DA111F2F4AD6B781CE289",
      "../GetImage.aspx?i=l-t_98476490_E-879285EBA96225706CDA5D044FEEABEFD6B7A50A",
      "../GetImage.aspx?i=l-t_98476490_F-2219E0411FB41680FD65B279A25E607506BD9339",
      "../GetImage.aspx?i=l-t_98476490_G-F062A3EC9DD501E8420B113649A541EC5231598A",
      "../GetImage.aspx?i=l-t_98476490_H-00C6619F5E5DD85CFF1E649C018CBF0DAE40AA24"
    ]
    @listing.image_paths.should == expected_paths
  end

end
