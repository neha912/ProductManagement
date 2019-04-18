Rails.application.routes.draw do
 
  # resources :products_import, only: [:new, :create]
  resources :products do
    collection { post :import } 
  end

  get 'users/show'
  devise_for :users 
  root to: 'welcome#home'



  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      resources :products, only: [:create]
      resources :sessions, only: [:create]
      delete '/sign_out' , to: 'sessions#destroy'
    end
  end

  
end
