Homes::Application.routes.draw do
  resources :lists do
    put 'listings/:id', :action => "add_listing", :as => "add_listing"
  end

  resources :listings do
    collection do 
      get "search"
      get "new_listings"
    end
  end

  root :to => "lists#show", :id => "undecided"
    

end
