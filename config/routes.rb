Rails.application.routes.draw do
  resources :weekly_plans
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "homepage#index"
    # Defines the root path route ("/")
  # root "posts#index"



  resources :users
  resources :session, only: [:create, :new , :destroy]

  namespace :customers do
    get 'dashboard', to: 'dashboards#index'
    resources :diet_plans, only: [:new, :create, :edit, :update]
    get 'weekly_plan', to: 'plans#show'
  end
  
end
