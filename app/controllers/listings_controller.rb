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

end
