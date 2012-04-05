class Listing < ActiveRecord::Base
  attr_accessible :url, :html, :short_sale, :mls_number, :street_address, :city, :state, :zip, :price
  has_many :listing_images
  belongs_to :list
end
