require 'spec_helper'

describe "locators/new.html.erb" do
  before(:each) do
    assign( :locator, FactoryGirl.build(:locator) )
  end

  it "should show the URL shortener form" do
    render
    rendered.should have_selector( 'form',     { :method => 'post', :action => '/locators/create'} ) 
    rendered.should have_selector( 'textarea', { :id => 'locator_url', :name => 'locator[url]' } )
    rendered.should have_selector( 'input',    { :type => 'submit' } )
  end

end
