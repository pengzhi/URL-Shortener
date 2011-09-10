require 'spec_helper'

describe LocatorsController do

  def valid_attributes
    { :url => 'http://localhost:3000/members/asdf/asdf' }
  end

  def invalid_attributes
    { :url => 'ht://localhost:3000/members/asdf/asdf' }
  end

  def random_url
    protocol     = "http://"
    domain_name  = "www." + Faker::Internet.domain_name
    user_name    = "/" + Faker::Internet.user_name
    query_string = "?first=this+is+a+field&second=was+it+clear+%28already%29%3F"
    
    [ protocol, domain_name, user_name, query_string ].join()
  end

  before do
    10.times{ FactoryGirl.create( :locator, :url => random_url ) }
    valid_hashes = Locator.find( :all ).collect( &:base36 )
    invalid_hashes = ['123','AsxsQ4','KKlask','Am5f%7']
    # make sure that invalid_hashes are not valid
    invalid_hashes.select{|x| !( valid_hashes.include? x ) }

    valid_hash, invalid_hash = valid_hashes.shuffle.first, invalid_hashes.shuffle.first
  end
  
  describe "(GET) NEW" do

    it "should be successful (200)" do
      get :new
      response.should be_success
    end

    it "should accept @locator as a new instance of Locator" do
      get :new
      assigns( :locator ).should be_a_new( Locator )
      assigns( :locator ).id.should be_nil 
    end

  end

  describe "(POST) CREATE" do

    describe "with valid params" do
    
      it "should be a successful redirect (302)" do 
        post :create, :locator => valid_attributes
        response.should be_redirect
      end
      
      it "should save the new instance of Locator" do
        expect {
          post :create, :locator => valid_attributes
        }.to change{ Locator.count }.by( 1 )
      end
      
      it "should redirects to the new page with the url shortened displayed in flash" do
        post :create, :locator => valid_attributes

        response.flash[:warning].should eql( Locator.last.shortened_url )
        response.should redirect_to( :new )
      end

    end
    
    describe "with invalid params" do
      
      it "should be successful (200)" do
        post :create, :locator => invalid_attributes
        response.should be_success
      end
      
      it "should not save the new instance" do
        expect {
          post :create, :locator => invalid_attributes
        }.not_to change{ Locator.count }
      end
      
      it "should now add errors in the instance and make it an invalid instance" do
        post :create, :locator => invalid_attributes
        assigns( :locator ).errors.should_not be_empty
      end
      
      it "should render the action 'new' with the invalid instance" do
        post :create, :locator => invalid_attributes
        assigns( :locator ).should be_a_new( Locator )
        response.should render_template("new")
      end

    end
  end
  
  describe "(GET) SHOW" do

    it "should assign @locators and @locator" do
      get :show, :hash => valid_hash
      locators = Locator.where( :base36 => valid_hase )
      locator  = locators.first
      assigns( :locators ).should eq( locators )
      assigns( :locator ).should  eq( locator )
    end
    
    it "should increment count/log referrer"

    it "should redirect to actual url with valid hash" do
      get :show, :hash => valid_hash
      assigns( :locators ).size.should eq(1)
      assigns( :locator ).class.should eq( Locator )
      response.should redirect_to( assigns(:locator).url )
    end
    
    it "should redirect to NEW with invalid hash" do
      get :show, :hash => invalid_hash
      assigns( :locator ).should eq( nil )
      response.should redirect_to( :new )
    end

  end

  describe "(GET) INDEX" do
    
    it "should show a list of shortened urls" do
      get :index
      locators = Locator.find( :all )
      assigns( :locators ).should eq( locators )
    end
  
  end
end
