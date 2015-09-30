class SavingAnimationPage
  constructor: (@container) ->
    @container       = "#{@container}"
    @h2              = "#{@container} h2"
    @line            = "#{@container} line--number"
    @h1              = "#{@container} h1"
    @h3              = "#{@container} h3"
    @h5              = "#{@container} h5"
    @arrow           = "#{@container} .arrow"
    @p               = "#{@container} p"
    @img             = "#{@container} img"
    
    @prepare() 

  prepare: ->
    TweenMax.set @container, autoAlpha: 0
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @line, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @h5,  autoAlpha: 0, y: 200
    TweenMax.set @arrow,  autoAlpha: 0, y: -100
    TweenMax.set @img, x: -1000,scaleX: 1
    TweenMax.set @p, {perspective:400}

  show: ->
    t = 0
    @tm = new TimelineMax paused: true
    #Split Text

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars

    mySplitTextP = new SplitText(@p, {type:"words"})
    wordsP = mySplitTextP.words

    @tm.to(@h1, 1,autoAlpha: 1, scrambleText:{text:"Economies ", chars:"Good job girl", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=1.5)
    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @h5, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    @tm.staggerFrom(wordsP, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "100% 200% 0",ease: Back.easeOut, 0.01, t+=.5)
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    
    @tm.play()

    @trainLoop()
  trainLoop: ->
    t = 0
    @tm = new TimelineMax paused: true, repeat: -1, yoyo: false, repeatDelay: 1.0
    @tm.to(@img,3,{x: 2000,ease: Ease.easeIn},t+=3)
    @tm.set(@img,{scaleX:1,ease: Ease.easeIn},t+=.2)
    @tm.to(@img,3,{x: -2000,ease: Ease.easeIn},t+=3)
    @tm.set(@img,{scaleX: -1,ease: Ease.easeIn},t+=.2)

    @tm.play()
  hide: ->
    @tm.reverse()
    # TweenMax.set @arrow,  autoAlpha: 0, y: -100

module.exports = SavingAnimationPage
