ActiveAdmin.register Game do
  menu priority: 2
  
  permit_params :name, :game_type, :store_id
end
