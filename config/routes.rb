Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "main#index"
  get "sign_up" => "registrations#new"
  post "sign_up" => "registrations#create"
  get "user" => "users#edit"
  patch "user" => "users#update"
  delete "logout" => "sessions#destroy"
  get "sign_in" => "sessions#new"
  post "sign_in" => "sessions#create"
  get "posts" => "posts#myposts"
  get "post" => "posts#new"
  post "post" => "posts#create"
  get 'posts/:user_id', to: 'posts#index'
  delete 'post/:post_id', to: 'posts#delete'
  get 'post/:post_id', to: 'posts#edit'
  patch 'post/:post_id', to: 'posts#update'
  get 'password', to: 'passwords#edit'
  patch 'password', to: 'passwords#update'
  get '/:post_id', to: 'publicposts#show'
  post "comment", to: 'publicposts#create_comment'
  get "comment/:post_id", to: 'publicposts#get_comments'
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
end
