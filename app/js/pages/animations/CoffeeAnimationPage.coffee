class CoffeeAnimationPage
  constructor: (@container) ->
   
    @container   = "#{@container}"

    # @section         = "#{@container} .section"
    @h2          = "#{@container} h2"
    @h1          = "#{@container} h1"
    @h3          = "#{@container} h3"
    @h6          = "#{@container} h6"
    @arrow       = "#{@container} .arrow"

    @shapes = "#{@container} path"
    @svg    = "#{@container} .coffee__svg"

    @prepare() 
  

  prepare: ->
    TweenMax.set [@container,@img], autoAlpha: 0
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @h6,  autoAlpha: 0, y: 200
    TweenMax.set @arrow,  autoAlpha: 0, y: -100
    # TweenMax.set @svg, 1, attr:{"fill-opacity":0}

  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    #Split Text
    mySplitTextH6 = new SplitText(@h6, {type:"words,chars"})
    charsH6 = mySplitTextH6.chars

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars


    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)
    @tm.staggerFrom(charsH6, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% 50% -50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.to(@h1, 1,autoAlpha: 1, scrambleText:{text:"café", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)


    @tm.staggerFromTo(@shapes, 1,  {drawSVG:"50% 50%"},{drawSVG:"100%"}, 0.1)
        .staggerTo(@shapes, 0.5, {stroke:"none", scale:1, opacity:0}, 0.2)
        .staggerTo(@shapes, 0.5, {fill:"#EFEEEC", scale:1, opacity:1}, 0.2)
    # @tm.to(@svg, .8,attr:{"fill-opacity":1}, t+=.2)
      # .fromTo(@shapes, 0.1,  {drawSVG:"10%", immediateRender:false},{drawSVG:"0%"}, "+=0.1")
      # .staggerTo(@shapes, 1, {drawSVG:"90% 100%"}, 0.5)

    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = CoffeeAnimationPage
