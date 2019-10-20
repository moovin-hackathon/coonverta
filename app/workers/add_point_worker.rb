class AddPointWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'
  
  def perform(user_id)
    user = User.find(user_id)
    if user.used_invitation_code.present?
      invitee_user = User.find_by(invitation_code: user.used_invitation_code)
      if invitee_user && invitee_user.actual_phase.step.to_s == '1'
        new_points = invitee_user.reward_points += 1
        invitee_user.reward_points = new_points
        invitee_user.save
      end
    end
  end
end