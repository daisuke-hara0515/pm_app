Rails.application.routes.draw do
  root 'static_page#home'
  get '/help', to:'static_page#help'
  get '/about', to:'static_page#about'
  get '/contact', to:'static_page#contact'
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'
  resources :users
  resources :account_activations,only: [:edit]
end
