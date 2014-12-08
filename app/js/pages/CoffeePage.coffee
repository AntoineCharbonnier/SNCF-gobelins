BasePage = require '../BasePage'

class CoffeePage extends BasePage
  constructor: () ->
    @container = '.coffee'

    super @container

    @animationClass = new (require './animations/CoffeeAnimationPage')(@container)

    console.log '[CoffeePage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = CoffeePage
  
