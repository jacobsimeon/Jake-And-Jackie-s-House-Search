require 'spec_helper.rb'

describe Listing do
  it 'has correct default values' do
    @listing = Listing.new
    @listing.save
    @listing.not_interested.should be_false
    @listing.interested.should be_false
  end
end
