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
    @locators = Locator.where( :base36 => params[:hash] )
    @locator  = @locators.first
    
    redirect_to @locatar.url
  end

  def index
  end

end
