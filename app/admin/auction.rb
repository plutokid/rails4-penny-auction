ActiveAdmin.register Auction do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params do
    permitted = [:title, :description, :start_price, :starts_at, :ends_at, :status]
    #permitted << :other if resource.something?
    permitted
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input  :description,    :as => :text
      f.input  :start_price,    :as => :number
      f.input  :starts_at,      :as => :datetime_select
    end
    f.actions
  end

  controller do
    # override the create action to add has_one association wit Bid model
    def create
      create!

      #create has_one association
      current_bid   = params[:auction][:start_price]
      @auction.bid  = Bid.create(current_bid: current_bid)
    end
  end
end
