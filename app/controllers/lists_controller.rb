class ListsController < ApplicationController

  after_filter do
    @title = @list.friendly_name
  end

  def index
  end

  def show
    @list = List.find_by_name(params[:id] || "undecided")
    @listings = @list.listings.paginate :page => params[:page], :per_page => 15
    @title = @list.friendly_name
  end

  def add_listing 
    @list = List.find_by_name params[:list_id]
    @listing = Listing.find params[:id]
    @listing.list = @list
    @listing.save
    redirect_to @list
  end

end
