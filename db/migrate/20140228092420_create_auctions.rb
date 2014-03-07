class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string    :title,           limit: 100,   null: false
      t.string    :description,     limit: 5000,  null: false
      t.decimal   :start_price,     precision: 10, scale: 2
      t.decimal   :current_price,   precision: 10, scale: 2
      t.datetime  :starts_at
      t.datetime  :ends_at
      t.string    :status,          limit: 10, default: 'pending'
      t.timestamps
    end
  end
end
