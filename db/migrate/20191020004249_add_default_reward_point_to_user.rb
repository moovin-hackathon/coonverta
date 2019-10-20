class AddDefaultRewardPointToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :reward_points, :integer, default: 0
  end
end
