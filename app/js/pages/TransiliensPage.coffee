BasePage = require '../BasePage'

class TransiliensPage extends BasePage
  constructor: () ->
    @container = '.transiliens'

    super @container

    @animationClass = new (require './animations/TransiliensAnimationPage')(@container)

    console.log '[TransiliensPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = TransiliensPage
  
