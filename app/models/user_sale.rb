class UserSale < ApplicationRecord
  belongs_to :user
  belongs_to :sale
end
