class RequestManagerSingleton
  instance = null
  @get: () ->
    instance ?= new @()

class RequestManager extends RequestManagerSingleton
  constructor: ->
    
    #@valueText = null

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
      p.input.style.borderTop = "2px solid #999"
      p.input.style.borderBottom = "2px solid #999"
      p.options = myOptions
      p.onChange = (text) ->
        p.startFrom = 0
        p.repaint()
        console.log p.input.value
        @valueText = p.input.value
        console.log @valueText
        return

      
      #console.log myOptions,"OPTIONS"
      p.input.maxLength = 50 # limit the max number of characters in the input text
      return

    request.send()
    
  getStations:->
    console.log "GET TEXT",@valueText

    


    

module.exports = RequestManager