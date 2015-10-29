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
    # @pages[PagesTypes.QUIZZ]       = new (require './pages/QuizzPage')()
    # @pages[PagesTypes.OPTICAL]     = new (require './pages/OpticalPage')()

    
  
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
            return
      return

    # request = new XMLHttpRequest()
    # request.open "GET", "http://anarchy.rayanmestiri.com/ecs-name/all", true
    # request.onload = (e) ->
    #   ecsName = JSON.parse(request.response)
    #   stations = []
    #   console.log "LOAD LINE"
    #   $.each ecsName, (index, item) ->
    #     stations.push
    #       ecs: index
    #       name: item

    #   i = 0
    # myOptions = []
    myOptions = ["CDG","GDN"]
    # while i < stations.length
    #   myOptions.push(stations[i].name)
    #   i++
    owner = document.getElementById("autocomplete__field")
    p = completely(owner,
      fontSize: "10px"
      promptInnerHTML: ""
    )
    p.options = myOptions
    p.hideDropDown()
    p.onChange = (text) ->
      p.hideDropDown()
      p.startFrom = 0
      p.repaint()
      @valueText = p.input.value
    p.input.maxLength = 50 # limit the max number of characters in the input text
    p.hideDropDown()

      # return

    # request.send()





    $(".ok").click =>
      # request = new XMLHttpRequest()
      # request.open "GET", "http://anarchy.rayanmestiri.com/ecs-name/all", false
      # request.onreadystatechange = (e) =>
      #   ecsName = JSON.parse(request.response)
      #   stations = []
      #   $.each ecsName, (index, item) ->
      #     stations.push
      #       ecs: index
      #       name: item
      #   i = 0
      #   while i < stations.length
      #     if(stations[i].name ==$(".textInput").val())
      #       @gare = stations[i].ecs
      #       @gareName = stations[i].name
      #       reg = new RegExp("[ :]+", "g")
      #       tab = $("select#valueA").val().split(reg)
      #       hour = parseInt(tab[0])
      #       if(hour<10)
      #         @realHour = "0"+hour
      #       else
      #         @realHour = hour
      #     i++   
      #   if request.readyState==4 && request.status==200
      #     console.log "SUCESS"
      #     request2 = new XMLHttpRequest()
      #     request2.open "GET", "http://anarchy.rayanmestiri.com/ecs-time/"+@gare+"/"+@realHour, false
      #     request2.onreadystatechange = (e) =>
      #       @numberPeopleInHour = JSON.parse(request2.response)
      #       if request2.readyState==4 && request2.status==200
      #         request3 = new XMLHttpRequest()
      #         request3.open "GET", "http://anarchy.rayanmestiri.com/ecs/"+@gare, false
      #         request3.onreadystatechange = (e) =>
      #           @numberTotalPassenger = JSON.parse(request3.response)
      #         request3.send()
      #     request2.send()
          
          
      # request.send()

      # console.log "GARE",@gareName
      # @percentPerson = Math.round((@numberPeopleInHour/@numberTotalPassenger)*100)


      reg = new RegExp("[ :]+", "g")
      tab = $("select#valueA").val().split(reg)
      hour = parseInt(tab[0])
      
      if(hour<10)
        @realHour = "0"+hour
      else
        @realHour = hour

      console.log @realHour

      # #easing data from reality experiences
      # if  ( 5 < @realHour < 6 ) || ( 20 < @realHour < 22 )
      #   console.log "AA"
      #   @easingSwitchLotPeople = Math.round(0+Math.random() * (5 - 1) + 1)

      # if  ( 6 < @realHour < 8 ) || ( 18 < @realHour < 19 )
      #   console.log "BB"
      #   @easingSwitchLotPeople = Math.round(0+Math.random() * (10 - 4) + 4)
      
      # if  ( 8 < @realHour < 10 ) || ( 16 < @realHour < 17 )
      #   console.log "CC"
      #   @easingSwitchLotPeople = Math.round(0+Math.random() * (20 - 8) + 8)

      # if  ( 10 < @realHour < 15 ) || ( 15 < @realHour < 16 )
      #   console.log "DD"
      #   @easingSwitchLotPeople = Math.round(0+Math.random() * (50 - 20) + 20)


      # #calculate values from data
      # if ( 5 < @realHour < 6 ) || ( 20 < @realHour < 22 )
      # # if @percentPerson <= 8
      #   @percentPerson    = 20
      #   @percentAffluence = Math.round(@percentPerson)+@easingSwitchLotPeople
      #   @percentSaving    = 50
      #   @percentStress    = Math.round(0+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      # if ( 6 < @realHour < 8 ) || ( 18 < @realHour < 19 )
      # # if @percentPerson >8
      #   @percentPerson    = 120
      #   @percentAffluence = Math.round(@percentPerson*2.15)+@easingSwitchLotPeople
      #   @percentSaving    = 0
      #   @percentStress    = Math.round(@percentPerson*2.33+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      # if ( 8 < @realHour < 10 ) || ( 16 < @realHour < 17 )
      # # if @percentPerson >10
      #   @percentPerson    = 80
      #   @percentAffluence = Math.round(@percentPerson*2.15)+@easingSwitchLotPeople
      #   @percentSaving    = 20
      #   @percentStress    = Math.round(@percentPerson*2.33+Math.random() * (8 - 2) + 2)+@easingSwitchLotPeople

      # if ( 10 < @realHour < 15 ) || ( 15 < @realHour < 16 )
      # # if @percentPerson >15
      #   @percentPerson    = 10
      #   @percentAffluence = @percentPerson*3+@easingSwitchLotPeople
      #   @percentSaving    = 70
      #   @percentStress    = (Math.round(@percentPerson*5+Math.random() * (40 - 15) + 15)+@easingSwitchLotPeople) * 0.33

      # @affluenceImg = switch
      #   when 0  <= @percentAffluence < 20 then 1
      #   when 20 <= @percentAffluence < 50  then 2
      #   when 50 <= @percentAffluence then 3

      # @savingImg = switch
      #   when 0  <= @percentSaving < 30 then 1
      #   when 30 <= @percentSaving < 50  then 2
      #   when 50 <= @percentSaving then 3

      # @stressImg = switch
      #   when 0  <= @percentStress < 20 then 1
      #   when 20 <= @percentStress < 50  then 2
      #   when 50 <= @percentStress then 3


      # HOW TO FUCK DATA 

      if ( @realHour == "05" )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10

      if ( @realHour == "06" )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 15

      if ( @realHour == "07" )
        @percentStress    = 120
        @percentSaving    = 0
        @percentAffluence = 200
      if ( @realHour == "08" )

        @percentStress    = 100
        @percentSaving    = 0
        @percentAffluence = 100
      
      if ( @realHour == "09" )
        @percentStress    = 70
        @percentSaving    = 5
        @percentAffluence = 95
      
      if ( @realHour == 10 )
        @percentStress    = 3
        @percentSaving    = 20
        @percentAffluence = 60
      
      if ( @realHour == 12 )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10
      
      if ( @realHour == 13 )
        @percentStress    = 5
        @percentSaving    = 50
        @percentAffluence = 5
      
      if ( @realHour == 14 )
        @percentStress    = 30
        @percentSaving    = 20
        @percentAffluence = 40
      
      if ( @realHour == 15 )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10
      
      if ( @realHour == 16 )
        @percentStress    = 5
        @percentSaving    = 45
        @percentAffluence = 15
      
      if ( @realHour == 17 )
        @percentStress    = 85
        @percentSaving    = 5
        @percentAffluence = 90
      
      if ( @realHour == 18 )
        @percentStress    = 200
        @percentSaving    = 0
        @percentAffluence = 100
      
      if ( @realHour == 19 )
        @percentStress    = 250
        @percentSaving    = 0
        @percentAffluence = 220
      
      if ( @realHour == 20 )
        @percentStress    = 30
        @percentSaving    = 20
        @percentAffluence = 50
      
      if ( @realHour == 21 )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10
      
      if ( @realHour == 22 )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10
      
      if ( @realHour == 23 )
        @percentStress    = 0
        @percentSaving    = 50
        @percentAffluence = 10



      console.log "affluence : ",@percentAffluence," saving : ",@percentSaving," stress : ",@percentStress

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
  

