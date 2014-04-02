class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer     :auction_id
      t.integer     :last_bidder
      t.decimal     :current_bid,   precision: 10, scale: 2
      t.string      :bids_history,  limit: 2000
      t.timestamps
    end
  end
end
