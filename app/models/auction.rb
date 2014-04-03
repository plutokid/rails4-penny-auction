class Auction < ActiveRecord::Base
  validates :title,         presence: true, length: { maximum: 100 }
  validates :description,   presence: true, length: { maximum: 500 }
  validates :start_price,   presence: true, numericality: true
  validates :starts_at,     presence: true
  validates :status,        presence: true


  has_one :bid
end
