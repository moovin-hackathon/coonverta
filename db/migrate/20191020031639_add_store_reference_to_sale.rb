class AddStoreReferenceToSale < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales, :store, index: true
  end
end
