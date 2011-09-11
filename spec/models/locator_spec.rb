require 'spec_helper'

describe Locator do
  before(:each) do
    @locator    = FactoryGirl.build( :locator )
    @attributes = FactoryGirl.attributes_for( :locator )
  end
  
  it "should have presence error on base36" do
    @locator.url = nil; @locator.base36 = nil # base36 is generated based on url
    @locator.should have(1).error_on( :base36 )
    @locator.errors[:base36].should be_include( "can't be blank" )
  end
  
  it "should have presence error on url" do
    @locator.attributes = @attributes.except( :url )
    @locator.should have(1).error_on( :url )
    @locator.errors[:url].should be_include( "can't be blank" )
  end
  
  it "should respond to shortened_url method"

end
