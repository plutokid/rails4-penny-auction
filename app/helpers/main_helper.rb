module MainHelper
  def int_from_decimal(dec)
    dec.to_int
  end

  def fractional_from_decimal(dec)
    parts   = dec.to_s.split(".")
    number  = parts.count > 1 ? parts[1].to_s : 0
    number = "0#{number}" if number.to_i < 10
    number
  end

  def get_auctions_bidder_name(auction)
    bidder_name = ''
    bidder_name = auction.bid.user.email unless auction.bid.user.nil?
    bidder_name
  end

  def get_secs_left(auction)
    #secs_left = ((auction.expires_at - Time.now) * 24 * 60 * 60).to_i
    secs_left = (auction.expires_at - Time.now).to_i
    secs_left = Random.rand(5...30) if secs_left < 0
  end
end
