Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'user#login'

  get '/login', to: 'user#login'
  get '/cadastro', to: 'user#new'
  get '/jogar', to: 'game#play'
end
