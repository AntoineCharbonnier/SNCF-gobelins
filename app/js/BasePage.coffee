class BasePage
  constructor: (@container) ->
    
    @offset = 0
    @shown  = no

    block   = document.querySelector @container
    if block?
      @offset = Number(block.getAttribute 'data-scroll-offset')

  
  show: ->
    # if @shown
    #   return 

    # @shown = yes
    @animationClass.show()

  hide: ->
    @animationClass.hide()

module.exports = BasePage