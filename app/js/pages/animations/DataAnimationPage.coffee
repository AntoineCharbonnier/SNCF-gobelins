class DataAnimationPage
  constructor: (@container) ->
    @container       = "#{@container}"
    
    #@h4Direction     = "#{@container} .direction"
    @h2              = "#{@container} .selected--line"
    @line            = "#{@container} line--number"
    @h3              = "#{@container} h3"
    @h5              = "#{@container} h5"
    
    @selectBoxChoose = "#{@container} .select__box .choose"
    @selectBoxOk     = "#{@container} .select__box .ok"
    @selectBoxLI     = "#{@container} .select__box li"
    @selectBoxTitle  = "#{@container} .select__box li.title"
    
    @h2Affluence     = "#{@container} .impact--affluence  h2.impact--subtitle"
    @h2Saving        = "#{@container} .impact--saving  h2.impact--subtitle"
    @h2Stress        = "#{@container} .impact--stress  h2.impact--subtitle"

    @h2AffluenceCount     = "#{@container} .impact--affluence  h2.count"
    @h2SavingCount        = "#{@container} .impact--saving  h2.count"
    @h2StressCount        = "#{@container} .impact--stress  h2.count"  

    @AffluenceImg     = "#{@container} .impact--affluence  img"
    @SavingImg        = "#{@container} .impact--saving  img"
    @StressImg        = "#{@container} .impact--stress  img" 

    @skip = ".skip"

    @prepare() 


  prepare: ->
    TweenMax.set @container, autoAlpha: 0
    #TweenMax.set @h4Direction, {perspective:400},autoAlpha: 0
    TweenMax.set @h2, {perspective:400}
    TweenMax.set @line, autoAlpha: 0
    TweenMax.set @h3,  autoAlpha: 0, x: 200
    TweenMax.set @h5,  autoAlpha: 0, y: 200

    TweenMax.set @selectBoxChoose, autoAlpha: 0
    TweenMax.set @selectBoxOk, autoAlpha: 0
    TweenMax.set @selectBoxTitle, autoAlpha: 0
    TweenMax.set @selectBoxLI, autoAlpha: 0
    TweenMax.set @h2Affluence, autoAlpha: 0
    TweenMax.set @h2Saving, autoAlpha: 0
    TweenMax.set @h2Stress, autoAlpha: 0
    TweenMax.set [@AffluenceImg,@SavingImg,@StressImg], autoAlpha: 0
    TweenMax.set @AffluenceImg, x: -300
    TweenMax.set @StressImg, x: 300
    TweenMax.set @SavingImg, y: -100



  show: ->
    t = 0
    @tm = new TimelineMax paused: true#, repeat: -1, yoyo: true, repeatDelay: 3.0
    #Split Text

    mySplitTextH2 = new SplitText(@h2, {type:"words,chars"})
    charsH2 = mySplitTextH2.chars

    #mySplitTextH4Direction = new SplitText(@h4Direction, {type:"words,chars"})
    #charsH4Direction = mySplitTextH4Direction.chars


    @tm.to( @container, 1.5,{autoAlpha: 1, ease: Ease.easeIn}, t+=.2)
    @tm.to( @skip, .5,{autoAlpha: 0, ease: Ease.easeIn}, t+=.2)
    

    @tm.staggerFrom(charsH2, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "0% -50% 50",ease: Back.easeOut, 0.01, t+=.8)
   #@tm.staggerFrom(charsH4Direction, 0.8,opacity: 0,scale: 0,y: 80,rotationX: 180,transformOrigin: "100% 50% 50",ease: Back.easeOut, 0.01, t+=.2)
    
 
    @tm.to(@selectBoxChoose, 1,{autoAlpha: 1,x: 0,ease: Back.easeOut},t+=.2)
    @tm.to(@selectBoxOk, 1,{autoAlpha: 1,x: 0,ease: Back.easeOut},t+=.2)
    @tm.to(@selectBoxLI, 1,{autoAlpha: 0,y: 0,ease: Back.easeOut},t+=.2)
    @tm.to(@selectBoxTitle, 1,{autoAlpha: 1,y: 0,ease: Back.easeOut},t+=.2)
    
    
    
    @tm.to( @h3, .5,{autoAlpha: 1,x: 0, ease: Back.easeOut}, t+=.2)
    @tm.to( @h5, .8,{autoAlpha: 1,y: 0, ease: Back.easeOut}, t+=.2)

    @tm.to(@h2Affluence, 1,autoAlpha: 1, scrambleText:{text:"Affluence ", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2Saving, 1,autoAlpha: 1, scrambleText:{text:"Economie ", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2Stress, 1,autoAlpha: 1, scrambleText:{text:"Stress ", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)

    @tm.to(@h2AffluenceCount, 1,autoAlpha: 1, scrambleText:{text:"---", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2SavingCount, 1,autoAlpha: 1, scrambleText:{text:"---", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2StressCount, 1,autoAlpha: 1, scrambleText:{text:"---", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)

    @tm.to(@AffluenceImg,1,{autoAlpha: 1,x: 0,ease: Back.easeOut},t+=.1)    
    @tm.to(@StressImg,1,{autoAlpha: 1,x: 0,ease: Back.easeOut},t+=.1)    
    @tm.to(@SavingImg,1,{autoAlpha: 1,y: 0,ease: Back.easeOut},t+=.1)    
    

    @tm.play()
  hide: ->
    @tm.reverse()

  updatePercent: (@affluence,@saving,@stress) ->
    console.log "UPDATE PERCENT"
    t = 0
    @tm = new TimelineMax paused: true
    @tm.to(@h2AffluenceCount, 1,autoAlpha: 1, scrambleText:{text:@affluence+"%", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2SavingCount, 1,autoAlpha: 1, scrambleText:{text:"-"+@saving+"%", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.to(@h2StressCount, 1,autoAlpha: 1, scrambleText:{text:"+"+@stress+"%", chars:"0123456789", revealDelay:0.5, tweenLength:false, ease:Linear.easeNone},t+=.5)
    @tm.play()
  
  updateImg: (@affluence,@saving,@stress) ->
    console.log "UPDATE IMG"

    @affluenceShow = "#{@AffluenceImg}.afflu-"+@affluence
    @savingShow = "#{@SavingImg}.eco-"+@saving
    @stressShow = "#{@StressImg}.stress-"+@stress

    console.log @affluenceShow

    t = 0
    @tm = new TimelineMax paused: true
    @tm.to([@AffluenceImg,@StressImg,@SavingImg],.2,{autoAlpha:0,ease: Ease.easeIn},t+=.2)
    @tm.to([@affluenceShow,@savingShow,@stressShow],.2,{autoAlpha:1,x:-2,ease: Ease.easeIn},t+=.2)
    @tm.to([@affluenceShow,@savingShow,@stressShow],.2,{x:2,ease: Ease.easeIn},t+=.2)
    @tm.to([@affluenceShow,@savingShow,@stressShow],.2,{x:-2,ease: Ease.easeIn},t+=.2)
    @tm.to([@affluenceShow,@savingShow,@stressShow],.2,{x:0,ease: Ease.easeIn},t+=.2)

#    @tm.to(@affluenceShow,.2,{autoAlpha:1,x:-2,ease: Ease.easeIn},t+=.2)
#    @tm.to(@affluenceShow,.2,{x:2,ease: Ease.easeIn},t+=.2)
 #   @tm.to(@affluenceShow,.2,{x:-2,ease: Ease.easeIn},t+=.2)
 #   @tm.to(@affluenceShow,.2,{x:0,ease: Ease.easeIn},t+=.2)

 #   @tm.to(@stressShow,.2,{autoAlpha:1,x:-2,ease: Ease.easeIn},t)
 #   @tm.to(@stressShow,.2,{x:2,ease: Ease.easeIn},t+=.2)
 #   @tm.to(@stressShow,.2,{x:-2,ease: Ease.easeIn},t+=.2)
 #   @tm.to(@stressShow,.2,{x:0,ease: Ease.easeIn},t+=.2)

  #  @tm.to(@savingShow,.2,{autoAlpha:1,x:-2,ease: Ease.easeIn},t)
  #  @tm.to(@savingShow,.2,{x:2,ease: Ease.easeIn},t+=.2)
  #  @tm.to(@savingShow,.2,{x:-2,ease: Ease.easeIn},t+=.2)
  #  @tm.to(@savingShow,.2,{x:0,ease: Ease.easeIn},t+=.2)

    @tm.play()

module.exports = DataAnimationPage
