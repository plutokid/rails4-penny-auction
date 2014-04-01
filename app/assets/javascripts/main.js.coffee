class @MainPage extends Rrs.PageModule
  components:
    userSession: UserSessionComponent.create()
    liveAuctionCounter: AuctionCounter.create()
    liveAuction: LiveAuctions.create()


$(document).ready ->
  MainPage.create()