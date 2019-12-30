Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :uber_proxy, only: [] do
    collection do
      get :attendee_search
    end
  end
end
