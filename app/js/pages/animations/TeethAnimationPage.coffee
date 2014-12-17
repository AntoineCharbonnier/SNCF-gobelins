class TeethAnimationPage
    
  constructor: (@container) ->
   
    @container = "#{@container}"
    
    @h2        = "#{@container} h2"
    @h1        = "#{@container} h1"
    @h3        = "#{@container} h3"
    @h6        = "#{@container} h6"
    @arrow     = "#{@container} .arrow"
    @img       = "#{@container}   .toothpaste"
    
    @shapes    = "#{@container} path"
    @svg       = "#{@container} .teeth__svg"
    @path0     = "#{@container} #teethPath0"
    @path1     = "#{@container} #teethPath1"
    @path2     = "#{@container} #teethPath2"
    @path3     = "#{@container} #teethPath3"
    @path4     = "#{@container} #teethPath4"
    @path5     = "#{@container} #teethPath5"
    @path6     = "#{@container} #teethPath6"
    @path7     = "#{@container} #teethPath7"
    @path8     = "#{@container} #teethPath8"
    @path9     = "#{@container} #teethPath9"
    @path10    = "#{@container} #teethPath10"
    @path11    = "#{@container} #teethPath11"
    @path12    = "#{@container} #teethPath12"
    @path13    = "#{@container} #teethPath13"
    
   
    @prepare() 
  

  prepare: ->
    TweenMax.set [@container,@img], autoAlpha: 0
    TweenMax.set @img, x:300
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
    @tm.to( @h1, 1,autoAlpha: 1, scrambleText:{text:"brosse à dents", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.3)
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)

    @tm.staggerFromTo(@shapes, 1,  {drawSVG:"50% 50%"},{drawSVG:"100%"}, 0.3,t+=.1)
        .staggerTo(@shapes, 0.5, {stroke:"none", scale:1, opacity:0}, 0.4,t+=.4)
    # @tm.to(@path1, 0.5, {stroke:"none", scale:1, opacity:0}, 0.4,t+=.4) 

    @tm.to(@path0, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path1, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path2, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path3, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path4, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path5, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path6, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path7, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path8, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path9, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path10, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path11, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path12, 0.2, {fill:"#F2F4F4", scale:1, opacity:1},t+=.4)
    @tm.to(@path13, 0.2, {fill:"#214E61", scale:1, opacity:1},t+=.4)
        # .staggerTo(@shapes, 0.5, {fill:"#EFEEEC", scale:1, opacity:1}, 0.2,t+=.5)

    @tm.to( @img, .3,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.3)    
    @tm.to( @h6, .3,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.3)    
    @tm.to( @arrow, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)

    
    @tm.play()

  hide: ->
    @tm.reverse()

module.exports = TeethAnimationPage
