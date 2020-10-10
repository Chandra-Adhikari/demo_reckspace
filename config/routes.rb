Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/create'
  root to: 'users#index'
  resources :users do
  	member do
  		get :member_list
  		post :add_friend
  	end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
