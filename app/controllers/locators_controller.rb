class LocatorsController < ApplicationController
  def new 
   @locator = Locator.new 
  end

  def create
    @locator = Locator.new params[:locator]
    
    if @locator.save
      flash[:success] = @locator.shortened_url
      redirect_to '/'
    else
      render :action => :new
    end
  end

  def show
    @locators = Locator.base36( params[:hash] )
    @locator  = @locators.first # there should only be one element in the array

    if @locator 
      @referrer = Referrer.find_or_create_by_name_and_locator_id( request.referrer, @locator.id )
      @referrer.hit += 1
      @referrer.save
      redirect_to @locator.url
    else
      flash[:error] = 'Invalid address entered'
      redirect_to :action => :new
    end
  end

  def index
    @locators = Locator.all( :include => :referrers)
  end

end
