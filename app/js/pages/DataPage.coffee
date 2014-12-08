BasePage = require '../BasePage'

class DataPage extends BasePage
  constructor: () ->
    @container = '.data'

    super @container

    @animationClass = new (require './animations/DataAnimationPage')(@container)

    console.log '[DataPage]'
    


  show: ->
    super()


  hide: ->

    super()

    

module.exports = DataPage
  
