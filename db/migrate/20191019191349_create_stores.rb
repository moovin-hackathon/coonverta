class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :api_key
      t.string :default_invitation_code

      t.timestamps
    end
  end
end
