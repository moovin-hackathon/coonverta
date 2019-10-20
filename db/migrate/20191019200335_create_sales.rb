class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :reward_points
      t.decimal :discount_value, precision: 8, scale: 2
      t.string :slug

      t.timestamps
    end
  end
end
