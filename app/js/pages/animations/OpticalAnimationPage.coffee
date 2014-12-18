class OpticalAnimationPage
  constructor: (@container) ->
    @container   = "#{@container}"

    @img         = "#{@container} img"
    @h2          = "#{@container} h2"
    @h1          = "#{@container} h1"
    @arrow       = "#{@container} .arrow"
    @arrowBug       = ".saving__container.arrow"
    @prepare() 

  prepare: ->
    console.log "Optical prepare"
    TweenMax.set [@container,@img], autoAlpha: 0
    TweenMax.set @img, x :-5000,rotation: 45
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @arrow,  autoAlpha: 0, y: -100
    TweenMax.set @arrowBug,  autoAlpha: 0
    $(".section saving__container").opacity = 0
  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    #Split Text

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars

    @tm.to(@h1, 1,autoAlpha: 1, scrambleText:{text:"Opticien", chars:"Come on boy !", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)

    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)
    @tm.to( @img, 1,{autoAlpha: 1,x: 0, ease: Ease.easeIn}, t+=.2)#,scale: 1
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    

    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = OpticalAnimationPage
