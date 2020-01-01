Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :uber_proxy, only: [] do
    collection do
      post :attendee_search
      post :get_departments
      get :get_departments
      get :get_shifts
      post :mark_shift_worked
      post :mark_shift_not_worked
      get :get_user_from_barcode
      post :admin_login
    end
  end
end
