BasePage = require '../BasePage'

class SavingPage extends BasePage
  constructor: () ->
    @container = '.saving'

    super @container

    @animationClass = new (require './animations/SavingAnimationPage')(@container)

    console.log '[SavingPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = SavingPage
  
