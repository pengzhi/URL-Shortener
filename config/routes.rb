UrlShortener::Application.routes.draw do
  # TODO: 
  # root that accepts id 
  # root that redirects to locators#new

  get "locators/new"

  post "locators/create"

  get "locators/show"

  get "locators/index"

end
