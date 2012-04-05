class ListingsController < ApplicationController

  def index
  end

  def show
    @listing = Listing.find params[:id]
  end

  def search
    @listings = Listing.where( 'street_address LIKE ?', "%#{params[:address]}%")
    .paginate(:page => params[:page], :per_page => 15)
  end

  def new_listings
    @listings = Listing.where(:created_at => (Time.now - 1.day).midnight..(Time.now + 1.day).midnight)
    .paginate(:page => params[:page], :per_page => 15)
    render :template => "listings/search"
  end

end
