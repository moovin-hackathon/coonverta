class SessionsController < ApplicationController
  def create 
    params.permit!
    user = User.authenticate(ddd: params[:ddd], 
                             phone_number: params[:phone_number], 
                             password: params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_game
    else
      flash.now.alert = "Invalid email or password"
      render "user/login"
    end
  end

  def destroy 
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
