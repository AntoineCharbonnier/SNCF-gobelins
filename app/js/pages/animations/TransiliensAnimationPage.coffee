class TransiliensAnimationPage
  constructor: (@container) ->
    @container   = "#{@container}"

    # @section         = "#{@container} .section"
    @img         = "#{@container} img"
    @h4          = "#{@container} h4"
    @h2          = "#{@container} h2"
    @h1          = "#{@container} h1"
    @h3          = "#{@container} h3"
    @h5          = "#{@container} h5"
    @arrow       = "#{@container} .arrow"
    
    @prepare() 

  prepare: ->
    TweenMax.set [@container,@img], autoAlpha: 0
    TweenMax.set @img, x :-5000, scale: "50%"
    TweenMax.set @h4, {perspective:400}
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @h1, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @h5,  autoAlpha: 0, y: 200
    TweenMax.set @arrow,  autoAlpha: 0, y: -100

  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    #Split Text
    mySplitTextH4 = new SplitText(@h4, {type:"words,chars"})
    charsH4 = mySplitTextH4.chars

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars

    # mySplitTextH1 = new SplitText(@h1, {type:"words,chars"})
    # charsH1 = mySplitTextH1.chars  
    @tm.to(@h1, 1,autoAlpha: 1, scrambleText:{text:"transiliens", chars:"Nique la sncf", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)

    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)
    @tm.to( @img, 1,{autoAlpha: 1,x: 0,scale: 1, ease: Ease.easeIn}, t+=.2)
    @tm.staggerFrom(charsH4, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% 50% -50",ease: Back.easeOut, 0.01, t+=.8)
    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
    # @tm.staggerFrom(charsH1, 0.8,{opacity: 0,scale: 0,y: 100,rotationX: 0,transformOrigin: "50% 0% 50",ease: Back.easeOut}, 0.01, t+=.4)
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @h5, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    

    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = TransiliensAnimationPage
