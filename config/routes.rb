Homes::Application.routes.draw do
  resources :lists do
    put 'listings/:id', :action => "add_listing", :as => "add_listing"
  end

  resources :listings do
    collection do 
      get "search"
    end
  end
    

end
