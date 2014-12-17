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

  updatePercent:(@affluence,@saving,@stress) ->
  	console.log "[DataPage update]"
  	@animationClass.updatePercent(@affluence,@saving,@stress)
  
  updateImg:(@affluence,@saving,@stress) ->
    console.log "[DataPage img]"
    @animationClass.updateImg(@affluence,@saving,@stress)

module.exports = DataPage
  
