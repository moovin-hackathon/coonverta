ActiveAdmin.register Phase do
  menu priority: 3
  permit_params :required_ponts, 
                :name, 
                :step, 
                :reward_points, 
                :game_id  
end
