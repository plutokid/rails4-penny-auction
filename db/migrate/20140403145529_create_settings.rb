class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer     :expiration_counter_max_secs
      t.string      :currency_symbol, default: '&euro;'
      t.timestamps
    end
  end
end
