class MainController < ApplicationController

  def index
    @live_auctions = Auction.all
  end
end
