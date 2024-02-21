Rails.application.routes.draw do
  get 'users/show'
  resources :static_pages
  resources :events, only: [:index, :new, :create, :show]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only:[:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "events#index"

  #STRIPE

  #root 'orders#new'
  resources :orders, only: [:new, :create]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
end
end
