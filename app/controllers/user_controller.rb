class UserController < ApplicationController
  def login 
  end

  def new
    @user = User.new
  end

  def create 
    params.permit!
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to game_play_path
    else
      render "new"
    end
  end
end
