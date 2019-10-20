class UserController < ApplicationController
  def login 
    redirect_to_game if current_user
  end

  def new
    redirect_to_game if current_user
    @user = User.new
  end

  def create 
    params.permit!
    @user = User.new(params[:user])

    store = Store.find_by(default_invitation_code: @user.used_invitation_code)
  
    if store 
      @user.store = store
    else
      invitee_user = User.find_by(invitation_code: @user.used_invitation_code)
      @user.store = invitee_user.store if invitee_user
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to_game
    else
      render "new"
    end
  end
end
