BasePage = require '../BasePage'

class QuizzPage extends BasePage
  constructor: () ->
    @container = '.quizz'

    super @container

    @animationClass = new (require './animations/QuizzAnimationPage')(@container)

    console.log '[QuizzPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = QuizzPage
  
