ActiveAdmin.register Store do
  menu priority: 1 

  filter :store
  filter :name
  filter :default_invitation_code

  permit_params :name, :default_invitation_code, :store

  index do
    column :name do |store|
      link_to(store.name, admin_store_path(store))
    end
    column :api_key 
    column :default_invitation_code
  end

  form do |f|
    f.inputs do
      f.input :store
      f.input :name
      f.input :default_invitation_code
    end
    f.actions
  end
end
