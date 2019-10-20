class AddStoreReferencesToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :store, index: true
  end
end
