class SetDefValToExpCntrInSettings < ActiveRecord::Migration
  def change
    change_column :settings, :expiration_counter_max_secs, :integer, :default => 30
  end
end
