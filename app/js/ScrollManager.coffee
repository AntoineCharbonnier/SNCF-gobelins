PagesTypes = require './PagesTypes'

class ScrollManagerSingleton
  instance = null
  @get: () ->
    instance ?= new @()

class ScrollManager extends ScrollManagerSingleton
  constructor: ->
    
    @index        = -1
    @pagesOffsets = []
    @keyArray     = [PagesTypes.TRANSILIENS, PagesTypes.COFFEE,PagesTypes.CLOCK, PagesTypes.TEETH,PagesTypes.SOLUTION, PagesTypes.TRAVEL , PagesTypes.SAVING,PagesTypes.DATA]

    @i = 0
    @isFirstScroll = yes
    @preventScroll = false
  addPages: (@pages,@i) ->


    for key, page of @pages
      if page.offset?
        @pagesOffsets.push page.offset

    window.addEventListener "mousewheel", @scroll, false
    @scroll()

  scroll:(e = null) =>
    return if @preventScroll
    @preventScroll = true
    window.setTimeout ()=>
      @preventScroll = false
    , 2000
    e = window.event or e # old IE support
    delta = Math.max(-1, Math.min(1, (e.wheelDelta or -e.detail)))
    console.log "               delta",delta
    console.log "index", @index
    

    if @isFirstScroll
      @index = @i
      # @index = if i-1 < 0 then 0 else i-1
      @pages[@keyArray[@index]].show()
      console.log "index first",@index
    else
      console.log "else"
      if delta == -1 
        console.log "DOWN"
        @i++
        @index = @i
        console.log "index after down",@index
        @pages[@keyArray[@index]].show()
      if delta == 1 
        if @index != 0
          @pages[@keyArray[@index]].hide()
          @i--
          @index = @i
          @pages[@keyArray[@index]].show()
          console.log "UP"





    @isFirstScroll = no    
    










module.exports = ScrollManager