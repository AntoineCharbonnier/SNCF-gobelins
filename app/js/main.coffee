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
    @pages[PagesTypes.QUIZZ]       = new (require './pages/QuizzPage')()
    @pages[PagesTypes.OPTICAL]     = new (require './pages/OpticalPage')()

    
  
    @gare
    @realHour
    @numberPeopleInHour
    @numberTotalPassenger
    @percentPerson

    @percentAffluence
    @percentSaving
    @percentStress

    @affluenceImg
    @savingImg
    @stressImg


    @scrollManager.addPages @pages,@scrollManager.i

    # set top
    window.scrollTop = 0
    #slider 
    $ ->
      $("select#valueA").selectToUISlider
        labels: 9
        sliderOptions:
          change: (e, ui) ->
            # console.log "hey" + ui.value + "    " + $("select#valueA").val()
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
        
        # console.log p.input.value
        @valueText = p.input.value
        # console.log @valueText
                    
      p.input.maxLength = 50 # limit the max number of characters in the input text
      p.hideDropDown()

      return

    request.send()





    #@requestManager = (require './RequestManager').get()  
    $(".ok").click =>
     # @requestManager = (require './RequestManager').get() 
     # console.log @requestManager
     # @requestManager.getStations()
      # console.log "value OK",$(".textInput").val()
      # console.log $("select#valueA").val()

      request = new XMLHttpRequest()
      request.open "GET", "http://anarchy.rayanmestiri.com/ecs-name/all", false
      request.onreadystatechange = (e) =>
        ecsName = JSON.parse(request.response)
        stations = []
        $.each ecsName, (index, item) ->
          stations.push
            ecs: index
            name: item
        i = 0
        while i < stations.length
          if(stations[i].name ==$(".textInput").val())
            @gare = stations[i].ecs
            @gareName = stations[i].name
            reg = new RegExp("[ :]+", "g")
            tab = $("select#valueA").val().split(reg)
            #console.log parseInt(tab[0])
            hour = parseInt(tab[0])
            if(hour<10)
              @realHour = "0"+hour
              #console.log "REAL HOUR",@realHour
            else
              @realHour = hour
          i++   
        if request.readyState==4 && request.status==200
          console.log "SUCESS"
          request2 = new XMLHttpRequest()
          request2.open "GET", "http://anarchy.rayanmestiri.com/ecs-time/"+@gare+"/"+@realHour, false
          request2.onreadystatechange = (e) =>
            @numberPeopleInHour = JSON.parse(request2.response)
            if request2.readyState==4 && request2.status==200
              request3 = new XMLHttpRequest()
              request3.open "GET", "http://anarchy.rayanmestiri.com/ecs/"+@gare, false
              request3.onreadystatechange = (e) =>
                @numberTotalPassenger = JSON.parse(request3.response)
              request3.send()
          request2.send()
          
          
      request.send()

      console.log "GARE",@gareName
      #console.log "at the end", @numberPeopleInHour,"  ",@numberTotalPassenger," percent : ",Math.round((@numberPeopleInHour/@numberTotalPassenger)*100)
      @percentPerson = Math.round((@numberPeopleInHour/@numberTotalPassenger)*100)

      #easing data from reality experiences
      if @numberTotalPassenger > 10000
        @easingSwitchLotPeople = Math.round(0+Math.random() * (5 - 1) + 1)

      if @numberTotalPassenger > 20000
        @easingSwitchLotPeople = Math.round(0+Math.random() * (10 - 4) + 4)
      
      if @numberTotalPassenger > 40000
        @easingSwitchLotPeople = Math.round(0+Math.random() * (20 - 8) + 8)

      if @numberTotalPassenger > 50000
        @easingSwitchLotPeople = Math.round(0+Math.random() * (50 - 20) + 20)


      #calculate values from data
      if @percentPerson <= 8
        @percentAffluence = Math.round(@percentPerson)+@easingSwitchLotPeople
        @percentSaving = 50
        @percentStress= Math.round(0+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      if @percentPerson >8
        @percentAffluence = Math.round(@percentPerson*2.15)+@easingSwitchLotPeople
        @percentSaving = 20
        @percentStress= Math.round(@percentPerson*2.33+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      if @percentPerson >10
        @percentAffluence = Math.round(@percentPerson*2.15)+@easingSwitchLotPeople
        @percentSaving = 5
        @percentStress= Math.round(@percentPerson*2.33+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      if @percentPerson >15
        @percentAffluence = @percentPerson*3+@easingSwitchLotPeople
        @percentSaving = 0
        @percentStress= Math.round(@percentPerson*5+Math.random() * (40 - 15) + 15)+@easingSwitchLotPeople

      @affluenceImg = switch
        when 0<= @percentAffluence < 20 then 1
        when 20<= @percentAffluence < 50  then 2
        when 50<= @percentAffluence then 3

      @savingImg = switch
        when 0<= @percentSaving < 30 then 1
        when 30<= @percentSaving < 50  then 2
        when 50<= @percentSaving then 3

      @stressImg = switch
        when 0<= @percentStress < 20 then 1
        when 20<= @percentStress < 50  then 2
        when 50<= @percentStress then 3

      console.log "affluence : ",@percentAffluence," saving : ",@percentSaving," stress : ",@percentStress
      # console.log @pages
      @pages[PagesTypes.DATA].updatePercent(@percentAffluence,@percentSaving,@percentStress)
      @pages[PagesTypes.DATA].updateImg(@affluenceImg,@savingImg,@stressImg)
      @pages[PagesTypes.DATA].updateGare(@gareName)



  resize: ->





app = null


# equal to jquery document ready function
document.addEventListener 'DOMContentLoaded', () =>
  app = new App()

    

  # resize app
  window.addEventListener 'resize', () =>
    app.resize()
  , false
  

