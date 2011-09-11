UrlShortener::Application.routes.draw do
  root :to => "locators#new"

  match '/:hash', { :controller => :locators, :action => :show } 

  get  "locators/new"

  post "locators/create"

  get  "locators/show"

  get  "locators/index"

end
