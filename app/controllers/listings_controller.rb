class ListingsController < ApplicationController
  before_filter do
    @sections = ['new', 'undecided', 'interested', 'not_interested']
    @active_section = (params[:list] || "undecided").downcase
  end

  def index
    case @active_section 
    when "interested"
      @listings = Listing.where :interested => true
    when "not_interested"
      @listings = Listing.where(:not_interested => true)
    when 'new'
      @listings = Listing.where(:created_at => (Time.now.midnight)..(Time.now + 1.day).midnight)
    else
      @listings = Listing.where(:not_interested => false, :interested => false)
    end
    @listings = @listings.paginate :page => params[:page], :per_page => 15
  end

  def show
    @listing = Listing.find params[:id]
    render :layout => false
  end

  def destroy
    @listing = Listing.find params[:id]
    @listing.not_interested = true 
    @listing.interested = false
    @listing.save
    redirect_to :action => :index 
  end

  def interested
    @listing = Listing.find params[:id]
    @listing.interested = true
    @listing.not_interested = false
    @listing.save
    redirect_to :action => :index 
  end

end
