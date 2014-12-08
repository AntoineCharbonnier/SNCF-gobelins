BasePage = require '../BasePage'

class TravelPage extends BasePage
  constructor: () ->
    @container = '.travel'

    super @container

    @animationClass = new (require './animations/TravelAnimationPage')(@container)

    console.log '[TravelPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = TravelPage
  
