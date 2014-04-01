class @AuctionCounter extends Rrs.Component
  configs:
    counterMaxVal: 30
    almostOverLimit: 7
    
  init: ->
    super 
    @_startBackCounter()
    
  elements: 
    timeLabels:     '.js-auction-item.live:not(.win) .time-left .value'
    auctionHolder:  ".js-auction-item"

    
  listeners:
    "reset-counter" : (data)->
      $timeLabel = $(".js-auction-#{data.auctionId}").find('.time-left .value')
      $timeLabel.attr 'data-secs-left', @configs.counterMaxVal

  _startBackCounter: ->
    setInterval =>
      @_timeCountDown()
    , 1000
    
  _timeCountDown: ->
    expiredAuctions = []
    $( @elements.timeLabels ).each (idx, el)=>
      
      $timeLabel = $(el)

      secsLeft = $timeLabel.attr 'data-secs-left'
      console.log secsLeft

      secsLeft -= 1
      auctionId = $timeLabel.closest( @elements.auctionHolder ).attr 'data-id'
      if secsLeft > 0
        $timeLabel.text @_secondsToInterval(secsLeft)
        $timeLabel.attr 'data-secs-left', secsLeft
        
        if secsLeft <= @configs.almostOverLimit
          @emit "almost-over", auctionId: auctionId
      else
        expiredAuctions.push auctionId
        
    if expiredAuctions.length > 0
      @emit 'counter-expired', 
        expiredAuctions: expiredAuctions

  _secondsToInterval: (inSeconds)->
    seconds = Math.floor(inSeconds)
    days    = Math.floor(seconds / 86400);
    seconds -= days * 86400;
    hours   = Math.floor(seconds / 3600);
    seconds -= hours * 3600;
    minutes = Math.floor(seconds / 60);
    seconds -= minutes * 60;

    if (hours < 10)
      hours = "0" + hours;
    if (minutes < 10)
      minutes = "0" + minutes;
    
    if (days > 0) or (hours > 0) or (minutes > 0) 
      if (seconds < 10)
        seconds = "0" + seconds
        
      timeLeft = hours + ':' + minutes + ':' + seconds
      if days > 0
        timeLeft = "#{days}d " + timeLeft
    else
      timeLeft = seconds
    
    return timeLeft