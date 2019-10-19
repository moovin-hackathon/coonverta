class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :ddd
      t.string :phone_number
      t.string :password_hash
      t.integer :reward_points
      t.string :invitation_code
      t.string :used_invitation_code

      t.timestamps
    end
  end
end
