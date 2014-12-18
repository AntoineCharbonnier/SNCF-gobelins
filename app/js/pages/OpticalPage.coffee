BasePage = require '../BasePage'

class OpticalPage extends BasePage
  constructor: () ->
    @container = '.optical'

    super @container

    @animationClass = new (require './animations/OpticalAnimationPage')(@container)

    console.log '[OpticalPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = OpticalPage
  
