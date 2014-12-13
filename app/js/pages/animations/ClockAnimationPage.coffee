class ClockAnimationPage
  constructor: (@container) ->
   
    @container = "#{@container}"
    # @section = "#{@container} .section"
    @h2        = "#{@container} h2"
    @h1        = "#{@container} h1"
    @h3        = "#{@container} h3"
    @h6        = "#{@container} h6"
    @arrow     = "#{@container} .arrow"
    
    @shapes    = "#{@container} path"
    @svg       = "#{@container} .clock__svg"
    @path0     = "#{@container} #clockPath0"
    @path1     = "#{@container} #clockPath1"
    @path2     = "#{@container} #clockPath2"
    @path3     = "#{@container} #clockPath3"
    

    @prepare() 
  

  prepare: ->
    TweenMax.set @container, autoAlpha: 0
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @h6,  autoAlpha: 0, y: 200
    TweenMax.set @arrow,  autoAlpha: 0, y: -100
   

  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    #Split Text
    mySplitTextH6 = new SplitText(@h6, {type:"words,chars"})
    charsH6 = mySplitTextH6.chars

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars


    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=4.50)
    @tm.staggerFrom(charsH6, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% 50% -50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.to( @h1, 1,autoAlpha: 1, scrambleText:{text:"réveil", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    
    @tm.staggerFromTo(@shapes, 1,  {drawSVG:"50% 50%"},{drawSVG:"100%"}, 0.3,t+=.1)
        .staggerTo(@shapes, 0.5, {stroke:"none", scale:1, opacity:0}, 0.4,t+=.4)
    # @tm.to(@path1, 0.5, {stroke:"none", scale:1, opacity:0}, 0.4,t+=.4)    
    @tm.to(@path0, 0.5, {fill:"#BA1543", scale:1, opacity:1},t+=.5)
    @tm.to(@path1, 0.5, {fill:"#F0F5E3", scale:1, opacity:1},t+=.5)
    @tm.to(@path2, 0.5, {fill:"#F0F5E3", scale:1, opacity:1},t+=.5)
    @tm.to(@path3, 0.5, {fill:"#F0F5E3", scale:1, opacity:1},t+=.5)
        # .staggerTo(@shapes, 0.5, {fill:"#EFEEEC", scale:1, opacity:1}, 0.2,t+=.5)

    @tm.to( @h6, .3,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.3)    
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)

    
    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = ClockAnimationPage
