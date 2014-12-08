BasePage = require '../BasePage'

class TeethPage extends BasePage
  constructor: () ->
    @container = '.teeth'

    super @container

    @animationClass = new (require './animations/TeethAnimationPage')(@container)

    console.log '[TeethPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = TeethPage
  
