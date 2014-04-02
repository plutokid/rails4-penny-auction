class RenameBidsLastBidderToUserId < ActiveRecord::Migration
  def change
    rename_column :bids, :last_bidder, :user_id
  end
end
