class Game < ApplicationRecord
  belongs_to :store

  @@game_types = ["points_count"]

  validates_presence_of :name
  validates_inclusion_of :game_type, in: @@game_types
end
