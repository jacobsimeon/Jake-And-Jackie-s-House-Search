class List < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :listings
  
  def to_param; name; end

  def friendly_name
    name.split('_').each { |s| s.capitalize! }.join(' ')
  end

end
