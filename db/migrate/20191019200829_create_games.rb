class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :game_type
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
