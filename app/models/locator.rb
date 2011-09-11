class Locator < ActiveRecord::Base
  validates_presence_of :url  
  # TODO: validates format of url

  has_many :referrers
  
  scope :base36, lambda{ |string| where( :id => string.to_i(36) ) }

  def base36
    id.to_s( 36 )
  end
  alias_method :shortened_url, :base36

end
