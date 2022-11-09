Rails.application.routes.draw do
  root "posts#index"

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit]

  resource :sessions, only: [:new, :destroy, :create]
end
