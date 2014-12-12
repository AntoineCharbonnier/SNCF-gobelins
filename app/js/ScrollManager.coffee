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
    @numberKeys = 0
    @isFirstScroll = yes
    @preventScroll = false
  addPages: (@pages,@i) ->


    for key, page of @pages
      if page.offset?
        @pagesOffsets.push page.offset

    window.addEventListener "mousewheel", @scroll, false
    window.addEventListener "keydown", @keyControl, false
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

      #count number of key in pages to know when stop the scroll    
      for key of @pages
        @numberKeys++

    else
      console.log "else"

      console.log "number",@numberKeys
      if delta == -1 
        if @index < @numberKeys-1
          console.log "DOWN"
          @pages[@keyArray[@index]].hide()
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


  keyControl:(e = null) =>
    e = window.event or e # old IE support
    if  e.keyCode == 40
      console.log "DOWN key"
      if @index < @numberKeys-1
          @pages[@keyArray[@index]].hide()
          @i++
          @index = @i
          @pages[@keyArray[@index]].show()
    if  e.keyCode == 38
      console.log "UP key"
      if @index != 0
          @pages[@keyArray[@index]].hide()
          @i--
          @index = @i
          @pages[@keyArray[@index]].show()
    

module.exports = ScrollManager