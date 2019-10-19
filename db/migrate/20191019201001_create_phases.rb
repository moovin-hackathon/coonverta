class CreatePhases < ActiveRecord::Migration[5.2]
  def change
    create_table :phases do |t|
      t.integer :required_ponts
      t.string :name
      t.string :step
      t.integer :reward_points
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
