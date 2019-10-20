Rails.application.routes.draw do
  get 'sessions/new'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require "sidekiq/web"
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV['SIDEKIQ_USER'] && password == ENV['SIDEKIQ_PASSWORD']
    end
  end

  root 'user#login'

  get '/login', to: 'user#login', as: 'user_login'
  post '/login', to: 'sessions#create', as: 'session_create'
  get '/logout', to: 'sessions#destroy', as: 'session_destroy'

  get '/cadastro', to: 'user#new', as: 'user_new'
  post '/cadastro', to: 'user#create', as: 'user_create'

  get '/jogar', to: 'game#play', as: 'game_play'

  get '/give-ten', to: 'game#give_10_points', as: 'game_give_10_points'
  get '/give-one', to: 'game#give_1_point', as: 'game_give_1_point'

  # API
  post '/api/batch-invite', to: 'api#batch_invite'
  get '/api/user-sales', to: 'api#sales_from_users'

end
