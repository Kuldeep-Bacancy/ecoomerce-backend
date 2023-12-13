Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'application#index'

  scope :api, constraints: { format: 'json' } do
    scope :v1 do
      post '/login', to: 'sessions#login'
      post '/signup', to: 'registrations#signup'
      delete '/logout', to: 'sessions#logout'

      resources :products, only: :index
    end
  end
end
