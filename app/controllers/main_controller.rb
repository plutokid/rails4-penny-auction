class MainController < ApplicationController

  def index
    #a = Auction.find(10)
    #a.update_attribute('expires_at', Time.now)
    #@live_auctions = Auction.select("*, extract('epoch' from expires_at) - extract('epoch' from now()) as secs_left").all
    @live_auctions = Auction.all
    #.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end
end
