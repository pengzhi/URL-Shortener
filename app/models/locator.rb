class Locator < ActiveRecord::Base
  validates_presence_of :base36
  validates_presence_of :url  
  # TODO: validates format of url

  before_validation :generate_base36

  def shortened_url
    self.base36
  end

  private

  def generate_base36
    value = ( url.nil? ? nil : "MeoW#{url}" )
    write_attribute :base36, value
  end
end
