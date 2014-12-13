PagesTypes = require './PagesTypes'

class App
  constructor: () ->
    console.log '[APP]'

    @scrollManager = (require './ScrollManager').get()

    @pages = {}
    @pages[PagesTypes.TRANSILIENS] = new (require './pages/TransiliensPage')()
    @pages[PagesTypes.COFFEE]      = new (require './pages/CoffeePage')()
    @pages[PagesTypes.CLOCK]       = new (require './pages/ClockPage')()
    @pages[PagesTypes.TEETH]       = new (require './pages/TeethPage')()
    @pages[PagesTypes.SOLUTION]    = new (require './pages/SolutionPage')()
    @pages[PagesTypes.TRAVEL]      = new (require './pages/TravelPage')()
    @pages[PagesTypes.SAVING]      = new (require './pages/SavingPage')()
    @pages[PagesTypes.DATA]        = new (require './pages/DataPage')()



    @scrollManager.addPages @pages,@scrollManager.i

    # set top
    window.scrollTop = 0

  resize: ->





app = null


# equal to jquery document ready function
document.addEventListener 'DOMContentLoaded', () =>
  app = new App()

  # resize app
  window.addEventListener 'resize', () =>
    app.resize()
  , false
  
