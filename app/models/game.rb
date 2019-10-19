class Game < ApplicationRecord
  belongs_to :store

  validates_presence_of :name
end
