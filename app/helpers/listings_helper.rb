module ListingsHelper

  def listing_image listing
    return image_tag(listing.listing_images.first.image.url(:medium))
  rescue
    return ""
  end

end
