# console.log "Hello"

# $('#coffeePath0').css({ fill: "#EFEEEC" });
# $('#coffeePath0').css({ stroke: "none" });

# $('#clockPath0').css({ fill: "#BA1543" });
# $('#clockPath0').css({ stroke: "none" });
# $('#clockPath1').css({ fill: "#F0F5E3" });
# $('#clockPath1').css({ stroke: "none" });
# $('#clockPath2').css({ fill: "#F0F5E3" });
# $('#clockPath2').css({ stroke: "none" });
# $('#clockPath3').css({ fill: "#F0F5E3" });
# $('#clockPath3').css({ stroke: "none" });


# $('#teethPath0').css({ fill: "#F2F4F4" });
# $('#teethPath0').css({ stroke: "none" });
# $('#teethPath1').css({ fill: "#F2F4F4" });
# $('#teethPath1').css({ stroke: "none" });
# $('#teethPath2').css({ fill: "#F2F4F4" });
# $('#teethPath2').css({ stroke: "none" });
# $('#teethPath3').css({ fill: "#F2F4F4" });
# $('#teethPath3').css({ stroke: "none" });
# $('#teethPath4').css({ fill: "#F2F4F4" });
# $('#teethPath4').css({ stroke: "none" });
# $('#teethPath5').css({ fill: "#F2F4F4" });
# $('#teethPath5').css({ stroke: "none" });
# $('#teethPath6').css({ fill: "#F2F4F4" });
# $('#teethPath6').css({ stroke: "none" });
# $('#teethPath7').css({ fill: "#F2F4F4" });
# $('#teethPath7').css({ stroke: "none" });
# $('#teethPath8').css({ fill: "#F2F4F4" });
# $('#teethPath8').css({ stroke: "none" });
# $('#teethPath9').css({ fill: "#F2F4F4" });
# $('#teethPath9').css({ stroke: "none" });
# $('#teethPath10').css({ fill: "#F2F4F4" });
# $('#teethPath10').css({ stroke: "none" });
# $('#teethPath11').css({ fill: "#F2F4F4" });
# $('#teethPath11').css({ stroke: "none" });
# $('#teethPath12').css({ fill: "#F2F4F4" });
# $('#teethPath12').css({ stroke: "none" });
# $('#teethPath13').css({ fill: "#214E61" });
# $('#teethPath13').css({ stroke: "none" });



# console.log "this is the end"



PagesTypes = require './PagesTypes'
# VideoModule = require './VideoModule'


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
    # @pages['introduction'].show()
    # @pages['meet-us'].show()
    # @video =  new (require './pages/VideoModule')() 

  resize: ->





app = null


# equal to jquery document ready function
document.addEventListener 'DOMContentLoaded', () =>
  app = new App()

  # resize app
  window.addEventListener 'resize', () =>
    app.resize()
  , false
  
