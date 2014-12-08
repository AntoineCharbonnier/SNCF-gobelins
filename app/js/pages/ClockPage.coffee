BasePage = require '../BasePage'

class ClockPage extends BasePage
  constructor: () ->
    @container = '.clock'

    super @container

    @animationClass = new (require './animations/ClockAnimationPage')(@container)

    console.log '[ClockPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = ClockPage
  
