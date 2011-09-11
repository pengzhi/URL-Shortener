class Referrer < ActiveRecord::Base
  belongs_to :locator
  validates_presence_of :locator_id
end
