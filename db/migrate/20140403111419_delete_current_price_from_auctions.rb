class DeleteCurrentPriceFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :current_price
    remove_column :auctions, :ends_at
  end
end
