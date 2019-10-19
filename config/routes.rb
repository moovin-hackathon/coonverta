Rails.application.routes.draw do
  get 'sessions/new'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'user#login'

  get '/login', to: 'user#login', as: 'user_login'
  post '/login', to: 'session#create', as: 'session_create'
  post '/logout', to: 'session#destroy', as: 'session_destroy'

  get '/cadastro', to: 'user#new', as: 'user_new'
  post '/cadastro', to: 'user#create', as: 'user_create'

  get '/jogar', to: 'game#play', as: 'game_play'
end
