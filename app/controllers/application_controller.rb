class ApplicationController < ActionController::Base
  helper_method :current_user

  def redirect_to_game
    redirect_to game_play_path
  end
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
