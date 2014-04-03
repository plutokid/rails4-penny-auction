ActiveAdmin.register Setting do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :expiration_counter_max_secs, :currency_symbol
  #
  # or
  #
  #permit_params do
  #  permitted = [:expiration_counter_max_secs, :currency_symbol]
  #  #permitted << :other if resource.something?
  #  permitted
  #end
  
end
