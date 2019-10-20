class Game < ApplicationRecord
  belongs_to :store
  has_many :phases

  validates_presence_of :name
end
