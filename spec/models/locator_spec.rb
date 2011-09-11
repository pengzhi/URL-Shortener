require 'spec_helper'

describe Locator do
  before(:each) do
    @locator    = FactoryGirl.build( :locator )
    @attributes = FactoryGirl.attributes_for( :locator )
  end
  
  it "should have presence error on url" do
    @locator.url = nil
    @locator.should have(1).error_on( :url )
    @locator.errors[:url].should be_include( "can't be blank" )
  end
  
  it "should respond to base36 named scope method" do
    Locator.should be_respond_to( :base36 )
  end

  it "should return the correct record using the base36 scope" do
    @locator.save
    a = Locator.find( @locator.id )
    b = Locator.base36( a.base36) 
    [ a ].should eq( b )
  end

  it "should respond to base36 instance method" do
    @locator.should be_respond_to( :base36 )
  end

end
