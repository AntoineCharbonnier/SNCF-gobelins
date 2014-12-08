BasePage = require '../BasePage'

class SolutionPage extends BasePage
  constructor: () ->
    @container = '.solutionToU'

    super @container

    @animationClass = new (require './animations/SolutionAnimationPage')(@container)

    console.log '[SolutionPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = SolutionPage
  
