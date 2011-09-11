require 'spec_helper'

describe "locators/new.html.erb" do
  before do
    
  end

  it "should show the URL shortener form" do
    render
    rendered.should have_selector( 'form', { :method => 'post', :action => '/'} ) do |f|
      f.should have_selector('input', { :name => 'locator[url]'} )
      f.should have_selector('input', { :type => 'submit' } )
    end
  end
end
