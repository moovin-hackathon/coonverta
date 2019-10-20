class GameController < ApplicationController
    layout 'play'
    def play
        @phase = current_user.actual_phase
        @invited_friends = @current_user.invited_friends.pluck(:name) if @phase.step == '1'
        @user_invitation_code = @current_user.invitation_code
        @sharing_treshold = 5
    end
end
