class ListingImage < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :image, :styles => { :medium => "300x300", :thumb => "100x100" }
end
