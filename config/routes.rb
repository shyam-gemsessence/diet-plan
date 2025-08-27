Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "homepage#index"
    # Defines the root path route ("/")
  # root "posts#index"

  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :sessions, only: [:create, :new ]

  resources :shops, only: [:index, :show, :new, :create ]
  

  namespace :customer do
    get 'view_plan', to: 'dashboard#view_plan'
    resources :selected_products, only: [:create]
  end

  namespace :owner do
    get 'customers', to: 'dashboard#customers'
    post 'generate_plan', to: 'dashboard#generate_plan'
    get 'report', to: 'dashboard#report'
    get 'shop', to: 'dashboard#shop'
    resources :products, only: [:create, :destroy]
  end
end
