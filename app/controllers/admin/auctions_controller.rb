class Admin::AuctionsController < ApplicationController
  layout "admin"

  def index
     @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  # POST /admin/auctions
  def create

  end
end
