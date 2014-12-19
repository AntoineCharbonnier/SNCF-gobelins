class SolutionAnimationPage
  constructor: (@container) ->
    @container   = "#{@container}"
    @h2          = "#{@container} h2"
    @h1          = "#{@container} h1"
    @h3          = "#{@container} h3"
    @arrow       = "#{@container} .arrow"
    
    @prepare() 

  prepare: ->

    TweenMax.set @h1, x: 0
    TweenMax.set @h2, x: 0
    TweenMax.set @h3, x: 0


    TweenMax.set @container, autoAlpha: 0
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @arrow,  autoAlpha: 0, x: 100

  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    
    #Split Text
    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars
    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=3.5)
    @tm.to(@h1, 1,autoAlpha: 1, scrambleText:{text:"solutions", chars:"Something gone wrong with you", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)

    
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)

    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @arrow, .8,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    
    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = SolutionAnimationPage
