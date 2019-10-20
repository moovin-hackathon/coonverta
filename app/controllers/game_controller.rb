class GameController < ApplicationController
  layout 'play'
  def play
    @phase = current_user.actual_phase
    @invited_friends = @current_user.invited_friends.pluck(:name) if @phase.step == '1'
    @user_invitation_code = @current_user.invitation_code
    @sharing_treshold = 1
    @sharing_message = "Use meu código para participar do game da #{@current_user.store.name}! Acesse http://bit.ly/2J3fP6o e se cadastre com o código #{@user_invitation_code} para participar e ganhar descontos!"
  end
  
  def give_10_points
    current_user
    @current_user.reward_points += 10
    @current_user.save

    redirect_to action: :play
  end

  def give_1_point 
    current_user
    @current_user.reward_points += 1
    @current_user.save

    redirect_to action: :play
  end
end
