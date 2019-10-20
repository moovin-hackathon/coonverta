class Sale < ApplicationRecord
  belongs_to :store
  has_many :user_sales
  has_many :users, through: :user_sales
end
