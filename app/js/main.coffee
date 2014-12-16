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

    
  
    @gare
    @heure

    @scrollManager.addPages @pages,@scrollManager.i

    # set top
    window.scrollTop = 0
    #slider 
    $ ->
      $("select#valueA").selectToUISlider
        labels: 9
        sliderOptions:
          change: (e, ui) ->
            console.log "hey" + ui.value + "    " + $("select#valueA").val()
            return
      return

    request = new XMLHttpRequest()
    request.open "GET", "http://anarchy.rayanmestiri.com/ecs-name/all", true
    request.onload = (e) ->
      ecsName = JSON.parse(request.response)
      stations = []

      $.each ecsName, (index, item) ->
        #console.log index, item
        stations.push
          ecs: index
          name: item

      #console.log stations

      i = 0
      myOptions = []
      while i < stations.length
        myOptions.push(stations[i].name)
        i++
          
      owner = document.getElementById("autocomplete__field")
      p = completely(owner,
        fontSize: "10px"
        promptInnerHTML: ""
      )
      # p.input.style.borderTop = "2px solid #999"
      # p.input.style.borderBottom = "2px solid #999"
      p.options = myOptions
      p.hideDropDown()
      p.onChange = (text) ->
        p.hideDropDown()
        p.startFrom = 0
        p.repaint()
        console.log p.input.value
        @valueText = p.input.value
        console.log @valueText
              
      p.input.maxLength = 50 # limit the max number of characters in the input text
      p.hideDropDown()
      return

    request.send()

    #@requestManager = (require './RequestManager').get()  
    $(".ok").click ->
     # @requestManager = (require './RequestManager').get() 
     # console.log @requestManager
     # @requestManager.getStations()
      console.log "value OK",$(".textInput").val()
      console.log $("select#valueA").val()

      request = new XMLHttpRequest()
      request.open "GET", "http://anarchy.rayanmestiri.com/ecs-name/all", true
      request.onload = (e) ->
        ecsName = JSON.parse(request.response)
        stations = []

        $.each ecsName, (index, item) ->
          #console.log index, item
          stations.push
            ecs: index
            name: item
        i = 0
        while i < stations.length
          # console.log stations[i].name
          if(stations[i].name ==$(".textInput").val())
            console.log "Find",stations[i].name
            @gare = stations[i].ecs
            console.log "THE GARE ECS",@gare,"     TIME",$("select#valueA").val()
            
            reg = new RegExp("[ :]+", "g")
            tab = $("select#valueA").val().split(reg)
            console.log parseInt(tab[0])
            hour = parseInt(tab[0])
            if(hour<10)
              realHour = "0"+hour
              console.log realHour
            else
              realHour = hour
            #final request
            request2 = new XMLHttpRequest()
            request2.open "GET", "http://anarchy.rayanmestiri.com/ecs-time/"+@gare+"/"+realHour, true
            request2.onload = (e) ->
              numberPeopleInHour = JSON.parse(request2.response)
              console.log numberPeopleInHour
            request2.send()

          i++
      request.send()
      
  resize: ->





app = null


# equal to jquery document ready function
document.addEventListener 'DOMContentLoaded', () =>
  app = new App()

    

  # resize app
  window.addEventListener 'resize', () =>
    app.resize()
  , false
  

