ActiveAdmin.register Sale do
  menu priority: 4
  permit_params :reward_points, 
                :discount_value,
                :slug
end
