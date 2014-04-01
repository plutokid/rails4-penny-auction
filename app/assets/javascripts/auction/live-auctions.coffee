class @LiveAuctions extends Rrs.Component
  init: ->
    super
#    @_attachAuctionUpdatedListener()
    
  elements:
    bidBtn  : '.js-do-bid'
    lastBid : '.last-bid .value'
    winner  : '.winner .value'
    auctionHolder: ".js-auction-item.live"
    
  handlers:
    'bidBtn click': (e)->
      auctionId = $(e.currentTarget).closest(@elements.auctionHolder).attr 'data-id'
#      @shared.socket.doBid auctionId
      
      
        
        
  listeners:
    "AuctionCounter:almost-over": (data)->
      auctionHolder = $(@elements.auctionHolder).filter("[data-id=#{data.auctionId}]")
      auctionHolder.find('.time-left').addClass 'almost-over'
      
    "AuctionCounter:counter-expired": (data)->
      console.log "*** AuctionCounter:counter-expired", data
      #find auction to simulate win and  process the rest auctions on the server
      expiredAuctions = []
      for auctionId in data.expiredAuctions
        auctionHolder = $(".js-auction-#{auctionId}")
        if auctionHolder.hasClass('swin-locked')
          #this auction is used to simulate win. Do not process it on the server for current user
          auctionHolder.addClass('win')
          @emit "show-winner-modal", auctionId: auctionId
        else
          expiredAuctions.push auctionId
          
#      @shared.socket.counterExpired expiredAuctions
      
  _attachAuctionUpdatedListener: ->
    @shared.socket.onAuctionUpdated (data)=>
#      console.log "auctions updated ", data
      for auctionData in data.auctions 
        @_renderAuctionData(auctionData)
        
#        @emit "hide-counter", auctionId: data.auction.id

  # Blinks price and useername if bidder has been changed
  #
  _blinkAuctionsIfChanged: (auctionHolder, auction)->
    currentWinnerName = auctionHolder.find('.winner .value').html()
#    console.log "BLINK", currentWinnerName, auction.winner
    if (currentWinnerName != '') and (currentWinnerName isnt auction.winner)
      auctionHolder.find('.last-bid').addClass 'blink'
      setTimeout ->
        auctionHolder.find('.last-bid').removeClass 'blink'
      , 1000
      
  _renderAuctionData: (auction)->
    auctionHolder = $(".js-auction-#{auction.id}")
    if (not auctionHolder.hasClass('swin-locked') ) and (not auctionHolder.hasClass('win'))
      #remove red backround from time counter (if exist)
      auctionHolder.find('.time-left .value-wraper').removeClass 'almost-over'
      
      #notify subscribed AuctionCounter that it must reset counter
      @emit "reset-counter", 
        auctionId: auction.id

      @emit "price-changed",
        auctionId : auction.id
        price     : auction.lastBid
        winner    : auction.winner   



      @_blinkAuctionsIfChanged(auctionHolder, auction)

      #display current winner and bid value
      auctionHolder.find( @elements.lastBid ).text auction.lastBid
      auctionHolder.find( @elements.winner ).text auction.winner

      #if auction is closed then show 'WIN' label and hide counter
      if auction.closed? and auction.closed 
        auctionHolder.addClass 'win'
      