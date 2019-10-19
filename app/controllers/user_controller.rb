class UserController < ApplicationController
  def login 
  end

  def new
  end

  def create 
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to game_play_path
    else
      render "new"
    end
  end
end
