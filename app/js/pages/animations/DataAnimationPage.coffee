class DataAnimationPage
  constructor: (@container) ->
    @container = "#{@container}"
    # console.log "TRANSILEN containrer",@container
    # @section         = "#{@container} .section"
    # @hr          = "#{@container} hr"
    # @p           = "#{@container} p.text--center"
    # @button      = "#{@container} .arrow__btn"
    # @buttonArrow = "#{@container} svg"

    # @addidas     = "#{@container} li.coffee__addidas"
    # @google      = "#{@container} li.coffee__google"
    # @samsung     = "#{@container} li.coffee__samsung"
    # @microsoft   = "#{@container} li.coffee__microsoft"

    # @coffeeLogo = "#{@container} li"

    # @bg          =  "#{@container} .coffee--background"



    @prepare() 
  

  prepare: ->
    # TweenMax.set @container, display: "none"
    TweenMax.set @container, autoAlpha: 0
    # TweenMax.set @hr, width: 0
    # TweenMax.set @h2, autoAlpha: 0, y: -5
    # TweenMax.set @buttonArrow, y: -15, autoAlpha: 0

    # TweenMax.set @coffeeLogo, autoAlpha: 0, y: 100
    # TweenMax.set @bg, autoAlpha: 0


  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    # @tm.to( @container, .1,{display: "table", ease: Ease.easeIn}, t)
    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)

    # @tm.to( @h2, .3, {autoAlpha: 1, y: 0, ease: Ease.easeIn}, t+=.2)
    # @tm.to( @hr, .6, {autoAlpha: 1, width: 60, ease: Back.easeOut}, t+=.3)
    # @tm.to( @p, .5, {autoAlpha: 1, ease: Ease.easeOut}, t+=.3)
    

    # @tm.staggerTo(@coffeeLogo, .5, {autoAlpha: 1, y: 0, ease: Back.easeOut}, .2, t+=.3)

    # @tm.to( @addidas, .5, {autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.3)
    # @tm.to( @google, .5, {autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    # @tm.to( @samsung, .5, {autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)
    # @tm.to( @microsoft, .5, {autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)

    @tm.play()

  hide: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0

    @tm.to( @container, 1.5,{autoAlpha: 0, ease: Ease.easeIn}, t+=.2)
    # @tm.to( @container, .1,{display: "none", ease: Ease.easeIn}, t)

    @tm.play()

module.exports = DataAnimationPage
