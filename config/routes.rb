Rails.application.routes.draw do
  root "posts#index"

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update]

  get 'users/:id/newpass', to: 'users#newpass', as: :newpass_user

  patch 'users/:id/update_password', to: 'users#update_password', as: :update_password

  resource :session, only: [:new, :destroy, :create]


end
