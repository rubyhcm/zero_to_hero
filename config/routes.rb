Rails.application.routes.draw do
  resources :articles do
    member do
      delete :purge_avatar
    end
  end
  # devise_for :users
  resources :telegrams, only: :index
  root 'homes#index'
  post '/group_message' => 'telegrams#group_message'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'users/registrations'
  }
end
