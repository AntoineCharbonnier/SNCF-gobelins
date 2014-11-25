###*
fullPage 2.4.8.1
https://github.com/alvarotrigo/fullPage.js
MIT licensed

Copyright (C) 2013 alvarotrigo.com - A project by Alvaro Trigo
###
(($) ->
  $.fn.fullpage = (options) ->
    
    # Create some defaults, extending them with any options that were provided
    
    #navigation
    
    #scrolling
    
    #Accessibility
    
    #design
    
    #Custom selectors
    
    #events
    
    #Defines the delay to take place before being able to scroll to the next section
    #BE CAREFUL! Not recommened to change it under 400 for a good behavior in laptops and
    #Apple devices (laptops, mouses...)
    
    #for IE touch devices
    
    #moving the container up
    
    #for IE touch devices
    
    #scrolling the page to the section with no animation
    
    ###*
    Defines the scrolling speed
    ###
    
    ###*
    Adds or remove the possiblity of scrolling through sections by using the mouse wheel or the trackpad.
    ###
    
    ###*
    Adds or remove the possiblity of scrolling through sections by using the mouse wheel/trackpad or touch gestures.
    ###
    
    ###*
    Adds or remove the possiblity of scrolling through sections by using the keyboard arrow keys
    ###
    
    #looping to the bottom if there's no more sections above
    
    #looping to the top if there's no more sections below
    
    ###*
    When resizing is finished, we adjust the slides sizes and positions
    ###
    
    #text and images resizing
    
    #adjusting the height of the table-cell for IE and Firefox
    
    #resizing the scrolling divs
    
    #adjusting the position fo the FULL WIDTH slides...
    
    #adjusting the position for the current section
    
    #isn't it the first section?
    
    #flag to avoid very fast sliding for landscape sliders
    
    #if css3 is not supported, it will use jQuery animations
    
    #adding a class to recognize the container internally in the code
    
    #trying to use fullpage without a selector?
    
    #adding internal class names to void problem with common ones
    
    #creating the navigation dots
    
    #if no active section is defined, the 1st one will be the default one
    
    # if there's any slide
    
    #if the slide won#t be an starting point, the default will be the first one
    
    #is there a starting point for a non-starting section?
    
    #the starting point is a slide?
    
    #the active section isn't the first one? Is not the first slide of the first section? Then we load that section/slide by default.
    
    #fixed elements need to be moved out of the plugin container due to problems with CSS3.
    
    #vertical centered of the navigation + first bullet active
    
    #moving the menu outside the main container if it is inside (avoid problems with fixed positions when using CSS3 tranforms)
    
    #after DOM and images are loaded
    
    #getting the anchor link in the URL and deleting the `#`
    
    #scrolling the page to the section with no animation
    
    #updating the active class
    
    ###*
    Creates a vertical navigation bar.
    ###
    addVerticalNavigation = ->
      $("body").append "<div id=\"fp-nav\"><ul></ul></div>"
      nav = $("#fp-nav")
      nav.css "color", options.navigationColor
      nav.addClass options.navigationPosition
      i = 0

      while i < $(".fp-section").length
        link = ""
        link = options.anchors[i]  if options.anchors.length
        li = "<li><a href=\"#" + link + "\"><span></span></a>"
        
        # Only add tooltip if needed (defined by user)
        tooltip = options.navigationTooltips[i]
        li += "<div class=\"fp-tooltip " + options.navigationPosition + "\">" + tooltip + "</div>"  if tooltip? and tooltip isnt ""
        li += "</li>"
        nav.find("ul").append li
        i++
      return
    createSlimScrollingHandler = ->
      $(".fp-section").each ->
        slides = $(this).find(".fp-slide")
        if slides.length
          slides.each ->
            createSlimScrolling $(this)
            return

        else
          createSlimScrolling $(this)
        return

      $.isFunction(options.afterRender) and options.afterRender.call(this)
      return
    
    #when scrolling...
    scrollHandler = ->
      if not options.autoScrolling or options.scrollBar
        currentScroll = $(window).scrollTop()
        visibleSectionIndex = 0
        initial = Math.abs(currentScroll - $(".fp-section").first().offset().top)
        
        #taking the section which is showing more content in the viewport
        $(".fp-section").each (index) ->
          current = Math.abs(currentScroll - $(this).offset().top)
          if current < initial
            visibleSectionIndex = index
            initial = current
          return

        
        #geting the last one, the current one on the screen
        currentSection = $(".fp-section").eq(visibleSectionIndex)
      unless options.autoScrolling
        
        #executing only once the first time we reach the section
        unless currentSection.hasClass("active")
          isScrolling = true
          leavingSection = $(".fp-section.active").index(".fp-section") + 1
          yMovement = getYmovement(currentSection)
          anchorLink = currentSection.data("anchor")
          currentSection.addClass("active").siblings().removeClass "active"
          unless isMoving
            $.isFunction(options.onLeave) and options.onLeave.call(this, leavingSection, (currentSection.index(".fp-section") + 1), yMovement)
            $.isFunction(options.afterLoad) and options.afterLoad.call(this, anchorLink, (currentSection.index(".fp-section") + 1))
          activateMenuAndNav anchorLink, 0
          if options.anchors.length and not isMoving
            
            #needed to enter in hashChange event when using the menu with anchor links
            lastScrolledDestiny = anchorLink
            location.hash = anchorLink
          
          #small timeout in order to avoid entering in hashChange event when scrolling is not finished yet
          clearTimeout scrollId
          scrollId = setTimeout(->
            isScrolling = false
            return
          , 100)
      if options.scrollBar
        
        #for the auto adjust of the viewport to fit a whole section
        clearTimeout scrollId2
        scrollId2 = setTimeout(->
          scrollPage currentSection  unless isMoving
          return
        , 1000)
      return
    
    ###*
    Determines whether the active section or slide is scrollable through and scrolling bar
    ###
    isScrollable = (activeSection) ->
      
      #if there are landscape slides, we check if the scrolling bar is in the current one or not
      if activeSection.find(".fp-slides").length
        scrollable = activeSection.find(".fp-slide.active").find(".fp-scrollable")
      else
        scrollable = activeSection.find(".fp-scrollable")
      scrollable
    
    ###*
    Determines the way of scrolling up or down:
    by 'automatically' scrolling a section or by using the default and normal scrolling.
    ###
    scrolling = (type, scrollable) ->
      if type is "down"
        check = "bottom"
        scrollSection = $.fn.fullpage.moveSectionDown
      else
        check = "top"
        scrollSection = $.fn.fullpage.moveSectionUp
      if scrollable.length > 0
        
        #is the scrollbar at the start/end of the scroll?
        if isScrolled(check, scrollable)
          scrollSection()
        else
          true
      else
        
        # moved up/down
        scrollSection()
      return
    
    # Detecting touch events
    #
    #   * As we are changing the top property of the page on scrolling, we can not use the traditional way to detect it.
    #   * This way, the touchstart and the touch moves shows an small difference between them which is the
    #   * used one to determine the direction.
    #   
    touchMoveHandler = (event) ->
      e = event.originalEvent
      
      # additional: if one of the normalScrollElements isn't within options.normalScrollElementTouchThreshold hops up the DOM chain
      unless checkParentForNormalScrollElement(event.target)
        
        #preventing the easing on iOS devices
        event.preventDefault()  if options.autoScrolling and not options.scrollBar
        activeSection = $(".fp-section.active")
        scrollable = isScrollable(activeSection)
        if not isMoving and not slideMoving #if theres any #
          touchEvents = getEventsPage(e)
          touchEndY = touchEvents["y"]
          touchEndX = touchEvents["x"]
          
          #if movement in the X axys is greater than in the Y and the currect section has slides...
          if activeSection.find(".fp-slides").length and Math.abs(touchStartX - touchEndX) > (Math.abs(touchStartY - touchEndY))
            
            #is the movement greater than the minimum resistance to scroll?
            if Math.abs(touchStartX - touchEndX) > ($(window).width() / 100 * options.touchSensitivity)
              if touchStartX > touchEndX
                $.fn.fullpage.moveSlideRight() #next
              else
                $.fn.fullpage.moveSlideLeft() #prev
          
          #vertical scrolling (only when autoScrolling is enabled)
          else if options.autoScrolling and not options.scrollBar
            
            #is the movement greater than the minimum resistance to scroll?
            if Math.abs(touchStartY - touchEndY) > ($(window).height() / 100 * options.touchSensitivity)
              if touchStartY > touchEndY
                scrolling "down", scrollable
              else scrolling "up", scrollable  if touchEndY > touchStartY
      return
    
    ###*
    recursive function to loop up the parent nodes to check if one of them exists in options.normalScrollElements
    Currently works well for iOS - Android might need some testing
    @param  {Element} el  target element / jquery selector (in subsequent nodes)
    @param  {int}     hop current hop compared to options.normalScrollElementTouchThreshold
    @return {boolean} true if there is a match to options.normalScrollElements
    ###
    checkParentForNormalScrollElement = (el, hop) ->
      hop = hop or 0
      parent = $(el).parent()
      if hop < options.normalScrollElementTouchThreshold and parent.is(options.normalScrollElements)
        true
      else if hop is options.normalScrollElementTouchThreshold
        false
      else
        checkParentForNormalScrollElement parent, ++hop
    touchStartHandler = (event) ->
      e = event.originalEvent
      touchEvents = getEventsPage(e)
      touchStartY = touchEvents["y"]
      touchStartX = touchEvents["x"]
      return
    
    ###*
    Detecting mousewheel scrolling
    
    http://blogs.sitepointstatic.com/examples/tech/mouse-wheel/index.html
    http://www.sitepoint.com/html5-javascript-mouse-wheel/
    ###
    MouseWheelHandler = (e) ->
      if options.autoScrolling
        
        # cross-browser wheel delta
        e = window.event or e
        delta = Math.max(-1, Math.min(1, (e.wheelDelta or -e.deltaY or -e.detail)))
        
        #preventing to scroll the site on mouse wheel when scrollbar is present
        (if e.preventDefault then e.preventDefault() else e.returnValue = false)  if options.scrollBar
        activeSection = $(".fp-section.active")
        scrollable = isScrollable(activeSection)
        unless isMoving #if theres any #
          #scrolling down?
          if delta < 0
            scrolling "down", scrollable
          
          #scrolling up?
          else
            scrolling "up", scrollable
        false
    moveSlide = (direction) ->
      activeSection = $(".fp-section.active")
      slides = activeSection.find(".fp-slides")
      
      # more than one slide needed and nothing should be sliding
      return  if not slides.length or slideMoving
      currentSlide = slides.find(".fp-slide.active")
      destiny = null
      if direction is "prev"
        destiny = currentSlide.prev(".fp-slide")
      else
        destiny = currentSlide.next(".fp-slide")
      
      #isn't there a next slide in the secuence?
      unless destiny.length
        
        #respect loopHorizontal settin
        return  unless options.loopHorizontal
        if direction is "prev"
          destiny = currentSlide.siblings(":last")
        else
          destiny = currentSlide.siblings(":first")
      slideMoving = true
      landscapeScroll slides, destiny
      return
    
    ###*
    Maintains the active slides in the viewport
    (Because he `scroll` animation might get lost with some actions, such as when using continuousVertical)
    ###
    keepSlidesPosition = ->
      $(".fp-slide.active").each ->
        silentLandscapeScroll $(this)
        return

      return
    
    ###*
    Scrolls the site to the given element and scrolls to the slide if a callback is given.
    ###
    scrollPage = (element, callback, isMovementUp) ->
      dest = element.position()
      return  if typeof dest is "undefined" #there's no element to scroll, leaving the function
      
      #local variables
      v =
        element: element
        callback: callback
        isMovementUp: isMovementUp
        dest: dest
        dtop: dest.top
        yMovement: getYmovement(element)
        anchorLink: element.data("anchor")
        sectionIndex: element.index(".fp-section")
        activeSlide: element.find(".fp-slide.active")
        activeSection: $(".fp-section.active")
        leavingSection: $(".fp-section.active").index(".fp-section") + 1
        
        #caching the value of isResizing at the momment the function is called
        #because it will be checked later inside a setTimeout and the value might change
        localIsResizing: isResizing

      
      #quiting when destination scroll is the same as the current one
      return  if (v.activeSection.is(element) and not isResizing) or (options.scrollBar and $(window).scrollTop() is v.dtop)
      if v.activeSlide.length
        slideAnchorLink = v.activeSlide.data("anchor")
        slideIndex = v.activeSlide.index()
      
      # If continuousVertical && we need to wrap around
      # Intending to scroll down but about to go up or
      # intending to scroll up but about to go down
      v = createInfiniteSections(v)  if options.autoScrolling and options.continuousVertical and typeof (v.isMovementUp) isnt "undefined" and ((not v.isMovementUp and v.yMovement is "up") or (v.isMovementUp and v.yMovement is "down"))
      element.addClass("active").siblings().removeClass "active"
      
      #preventing from activating the MouseWheelHandler event
      #more than once if the page is scrolling
      isMoving = true
      setURLHash slideIndex, slideAnchorLink, v.anchorLink, v.sectionIndex  if typeof v.anchorLink isnt "undefined"
      
      #callback (onLeave) if the site is not just resizing and readjusting the slides
      $.isFunction(options.onLeave) and not v.localIsResizing and options.onLeave.call(this, v.leavingSection, (v.sectionIndex + 1), v.yMovement)
      performMovement v
      
      #flag to avoid callingn `scrollPage()` twice in case of using anchor links
      lastScrolledDestiny = v.anchorLink
      
      #avoid firing it twice (as it does also on scroll)
      activateMenuAndNav v.anchorLink, v.sectionIndex  if options.autoScrolling
      return
    
    ###*
    Performs the movement (by CSS3 or by jQuery)
    ###
    performMovement = (v) ->
      
      # using CSS3 translate functionality
      if options.css3 and options.autoScrolling and not options.scrollBar
        translate3d = "translate3d(0px, -" + v.dtop + "px, 0px)"
        transformContainer translate3d, true
        setTimeout (->
          afterSectionLoads v
          return
        ), options.scrollingSpeed
      
      # using jQuery animate
      else
        scrollSettings = getScrollSettings(v)
        $(scrollSettings.element).animate(scrollSettings.options, options.scrollingSpeed, options.easing).promise().done -> #only one single callback in case of animating  `html, body`
          afterSectionLoads v
          return

      return
    
    ###*
    Gets the scrolling settings depending on the plugin autoScrolling option
    ###
    getScrollSettings = (v) ->
      scroll = {}
      if options.autoScrolling and not options.scrollBar
        scroll.options = top: -v.dtop
        scroll.element = "." + wrapperSelector
      else
        scroll.options = scrollTop: v.dtop
        scroll.element = "html, body"
      scroll
    
    ###*
    Adds sections before or after the current one to create the infinite effect.
    ###
    createInfiniteSections = (v) ->
      
      # Scrolling down
      unless v.isMovementUp
        
        # Move all previous sections to after the active section
        $(".fp-section.active").after v.activeSection.prevAll(".fp-section").get().reverse()
      else # Scrolling up
        # Move all next sections to before the active section
        $(".fp-section.active").before v.activeSection.nextAll(".fp-section")
      
      # Maintain the displayed position (now that we changed the element order)
      silentScroll $(".fp-section.active").position().top
      
      # Maintain the active slides visible in the viewport
      keepSlidesPosition()
      
      # save for later the elements that still need to be reordered
      v.wrapAroundElements = v.activeSection
      
      # Recalculate animation variables
      v.dest = v.element.position()
      v.dtop = v.dest.top
      v.yMovement = getYmovement(v.element)
      v
    
    ###*
    Fix section order after continuousVertical changes have been animated
    ###
    continuousVerticalFixSectionOrder = (v) ->
      
      # If continuousVertical is in effect (and autoScrolling would also be in effect then),
      # finish moving the elements around so the direct navigation will function more simply
      return  if not v.wrapAroundElements or not v.wrapAroundElements.length
      if v.isMovementUp
        $(".fp-section:first").before v.wrapAroundElements
      else
        $(".fp-section:last").after v.wrapAroundElements
      silentScroll $(".fp-section.active").position().top
      
      # Maintain the active slides visible in the viewport
      keepSlidesPosition()
      return
    
    ###*
    Actions to do once the section is loaded
    ###
    afterSectionLoads = (v) ->
      continuousVerticalFixSectionOrder v
      
      #callback (afterLoad) if the site is not just resizing and readjusting the slides
      $.isFunction(options.afterLoad) and not v.localIsResizing and options.afterLoad.call(this, v.anchorLink, (v.sectionIndex + 1))
      setTimeout (->
        isMoving = false
        $.isFunction(v.callback) and v.callback.call(this)
        return
      ), scrollDelay
      return
    
    ###*
    Scrolls to the anchor in the URL when loading the site
    ###
    scrollToAnchor = ->
      
      #getting the anchor link in the URL and deleting the `#`
      value = window.location.hash.replace("#", "").split("/")
      section = value[0]
      slide = value[1]
      #if theres any #
      scrollPageAndSlide section, slide  if section
      return
    
    #detecting any change on the URL to scroll to the given anchor link
    #(a way to detect back history button as we play with the hashes on the URL)
    hashChangeHandler = ->
      unless isScrolling
        value = window.location.hash.replace("#", "").split("/")
        section = value[0]
        slide = value[1]
        if section.length
          
          #when moving to a slide in the first section for the first time (first time to add an anchor to the URL)
          isFirstSlideMove = (typeof lastScrolledDestiny is "undefined")
          isFirstScrollMove = (typeof lastScrolledDestiny is "undefined" and typeof slide is "undefined" and not slideMoving)
          
          #in order to call scrollpage() only once for each destination at a time
          #         It is called twice for each scroll otherwise, as in case of using anchorlinks `hashChange`
          #         event is fired on every scroll too.
          scrollPageAndSlide section, slide  if (section and section isnt lastScrolledDestiny) and not isFirstSlideMove or isFirstScrollMove or (not slideMoving and lastScrolledSlide isnt slide)
      return
    
    ###*
    Sliding with arrow keys, both, vertical and horizontal
    ###
    
    #Moving the main page with the keyboard arrows if keyboard scrolling is enabled
    
    #up
    
    #down
    
    #Home
    
    #End
    
    #left
    
    #right
    # exit this handler for other keys
    
    ###*
    Scrolls to the section when clicking the navigation bullet
    ###
    
    ###*
    Scrolls the slider to the given slide destination for the given section
    ###
    
    ###*
    Scrolling horizontally when clicking on the slider controls.
    ###
    
    ###*
    Scrolls horizontal sliders.
    ###
    landscapeScroll = (slides, destiny) ->
      destinyPos = destiny.position()
      slidesContainer = slides.find(".fp-slidesContainer").parent()
      slideIndex = destiny.index()
      section = slides.closest(".fp-section")
      sectionIndex = section.index(".fp-section")
      anchorLink = section.data("anchor")
      slidesNav = section.find(".fp-slidesNav")
      slideAnchor = destiny.data("anchor")
      
      #caching the value of isResizing at the momment the function is called
      #because it will be checked later inside a setTimeout and the value might change
      localIsResizing = isResizing
      if options.onSlideLeave
        prevSlideIndex = section.find(".fp-slide.active").index()
        xMovement = getXmovement(prevSlideIndex, slideIndex)
        
        #if the site is not just resizing and readjusting the slides
        $.isFunction(options.onSlideLeave) and options.onSlideLeave.call(this, anchorLink, (sectionIndex + 1), prevSlideIndex, xMovement)  if not localIsResizing and xMovement isnt "none"
      destiny.addClass("active").siblings().removeClass "active"
      slideAnchor = slideIndex  if typeof slideAnchor is "undefined"
      unless options.loopHorizontal
        
        #hidding it for the fist slide, showing for the rest
        section.find(".fp-controlArrow.fp-prev").toggle slideIndex isnt 0
        
        #hidding it for the last slide, showing for the rest
        section.find(".fp-controlArrow.fp-next").toggle not destiny.is(":last-child")
      
      #only changing the URL if the slides are in the current section (not for resize re-adjusting)
      setURLHash slideIndex, slideAnchor, anchorLink, sectionIndex  if section.hasClass("active")
      afterSlideLoads = ->
        
        #if the site is not just resizing and readjusting the slides
        $.isFunction(options.afterSlideLoad) and options.afterSlideLoad.call(this, anchorLink, (sectionIndex + 1), slideAnchor, slideIndex)  unless localIsResizing
        
        #letting them slide again
        slideMoving = false
        return

      if options.css3
        translate3d = "translate3d(-" + destinyPos.left + "px, 0px, 0px)"
        addAnimation(slides.find(".fp-slidesContainer"), options.scrollingSpeed > 0).css getTransforms(translate3d)
        setTimeout (->
          afterSlideLoads()
          return
        ), options.scrollingSpeed, options.easing
      else
        slidesContainer.animate
          scrollLeft: destinyPos.left
        , options.scrollingSpeed, options.easing, ->
          afterSlideLoads()
          return

      slidesNav.find(".active").removeClass "active"
      slidesNav.find("li").eq(slideIndex).find("a").addClass "active"
      return
    
    #when resizing the site, we adjust the heights of the sections, slimScroll...
    resizeHandler = ->
      
      #checking if it needs to get responsive
      responsive()
      
      # rebuild immediately on touch devices
      if isTouchDevice
        
        #if the keyboard is visible
        if $(document.activeElement).attr("type") isnt "text"
          currentHeight = $(window).height()
          
          #making sure the change in the viewport size is enough to force a rebuild. (20 % of the window to avoid problems when hidding scroll bars)
          if Math.abs(currentHeight - previousHeight) > (20 * Math.max(previousHeight, currentHeight) / 100)
            $.fn.fullpage.reBuild true
            previousHeight = currentHeight
      else
        
        #in order to call the functions only when the resize is finished
        #http://stackoverflow.com/questions/4298612/jquery-how-to-call-resize-event-only-once-its-finished-resizing
        clearTimeout resizeId
        resizeId = setTimeout(->
          $.fn.fullpage.reBuild true
          return
        , 500)
      return
    
    ###*
    Checks if the site needs to get responsive and disables autoScrolling if so.
    A class `fp-responsive` is added to the plugin's container in case the user wants to use it for his own responsive CSS.
    ###
    responsive = ->
      if options.responsive
        isResponsive = container.hasClass("fp-responsive")
        if $(window).width() < options.responsive
          unless isResponsive
            $.fn.fullpage.setAutoScrolling false
            $("#fp-nav").hide()
            container.addClass "fp-responsive"
        else if isResponsive
          $.fn.fullpage.setAutoScrolling true
          $("#fp-nav").show()
          container.removeClass "fp-responsive"
      return
    
    ###*
    Toogles transition animations for the given element
    ###
    addAnimation = (element, adding) ->
      transition = "all " + options.scrollingSpeed + "ms " + options.easingcss3
      if adding
        element.removeClass "fp-notransition"
        return element.css(
          "-webkit-transition": transition
          transition: transition
        )
      
      #removing the animation
      removeAnimation element
    
    ###*
    Remove transition animations for the given element
    ###
    removeAnimation = (element) ->
      element.addClass "fp-notransition"
    
    ###*
    Resizing of the font size depending on the window size as well as some of the images on the site.
    ###
    resizeMe = (displayHeight, displayWidth) ->
      
      #Standard dimensions, for which the body font size is correct
      preferredHeight = 825
      preferredWidth = 900
      if displayHeight < preferredHeight or displayWidth < preferredWidth
        heightPercentage = (displayHeight * 100) / preferredHeight
        widthPercentage = (displayWidth * 100) / preferredWidth
        percentage = Math.min(heightPercentage, widthPercentage)
        newFontSize = percentage.toFixed(2)
        $("body").css "font-size", newFontSize + "%"
      else
        $("body").css "font-size", "100%"
      return
    
    ###*
    Activating the website navigation dots according to the given slide name.
    ###
    activateNavDots = (name, sectionIndex) ->
      if options.navigation
        $("#fp-nav").find(".active").removeClass "active"
        if name
          $("#fp-nav").find("a[href=\"#" + name + "\"]").addClass "active"
        else
          $("#fp-nav").find("li").eq(sectionIndex).find("a").addClass "active"
      return
    
    ###*
    Activating the website main menu elements according to the given slide name.
    ###
    activateMenuElement = (name) ->
      if options.menu
        $(options.menu).find(".active").removeClass "active"
        $(options.menu).find("[data-menuanchor=\"" + name + "\"]").addClass "active"
      return
    activateMenuAndNav = (anchor, index) ->
      activateMenuElement anchor
      activateNavDots anchor, index
      return
    
    ###*
    Return a boolean depending on whether the scrollable element is at the end or at the start of the scrolling
    depending on the given type.
    ###
    isScrolled = (type, scrollable) ->
      if type is "top"
        not scrollable.scrollTop()
      else scrollable.scrollTop() + 1 + scrollable.innerHeight() >= scrollable[0].scrollHeight  if type is "bottom"
    
    ###*
    Retuns `up` or `down` depending on the scrolling movement to reach its destination
    from the current section.
    ###
    getYmovement = (destiny) ->
      fromIndex = $(".fp-section.active").index(".fp-section")
      toIndex = destiny.index(".fp-section")
      return "none"  if fromIndex is toIndex
      return "up"  if fromIndex > toIndex
      "down"
    
    ###*
    Retuns `right` or `left` depending on the scrolling movement to reach its destination
    from the current slide.
    ###
    getXmovement = (fromIndex, toIndex) ->
      return "none"  if fromIndex is toIndex
      return "left"  if fromIndex > toIndex
      "right"
    createSlimScrolling = (element) ->
      
      #needed to make `scrollHeight` work under Opera 12
      element.css "overflow", "hidden"
      
      #in case element is a slide
      section = element.closest(".fp-section")
      scrollable = element.find(".fp-scrollable")
      
      #if there was scroll, the contentHeight will be the one in the scrollable section
      if scrollable.length
        contentHeight = scrollable.get(0).scrollHeight
      else
        contentHeight = element.get(0).scrollHeight
        contentHeight = element.find(".fp-tableCell").get(0).scrollHeight  if options.verticalCentered
      scrollHeight = windowsHeight - parseInt(section.css("padding-bottom")) - parseInt(section.css("padding-top"))
      
      #needs scroll?
      if contentHeight > scrollHeight
        
        #was there already an scroll ? Updating it
        if scrollable.length
          scrollable.css("height", scrollHeight + "px").parent().css "height", scrollHeight + "px"
        
        #creating the scrolling
        else
          if options.verticalCentered
            element.find(".fp-tableCell").wrapInner "<div class=\"fp-scrollable\" />"
          else
            element.wrapInner "<div class=\"fp-scrollable\" />"
          element.find(".fp-scrollable").slimScroll
            allowPageScroll: true
            height: scrollHeight + "px"
            size: "10px"
            alwaysVisible: true

      
      #removing the scrolling when it is not necessary anymore
      else
        removeSlimScroll element
      
      #undo
      element.css "overflow", ""
      return
    removeSlimScroll = (element) ->
      element.find(".fp-scrollable").children().first().unwrap().unwrap()
      element.find(".slimScrollBar").remove()
      element.find(".slimScrollRail").remove()
      return
    addTableClass = (element) ->
      element.addClass("fp-table").wrapInner "<div class=\"fp-tableCell\" style=\"height:" + getTableHeight(element) + "px;\" />"
      return
    getTableHeight = (element) ->
      sectionHeight = windowsHeight
      if options.paddingTop or options.paddingBottom
        section = element
        section = element.closest(".fp-section")  unless section.hasClass("fp-section")
        paddings = parseInt(section.css("padding-top")) + parseInt(section.css("padding-bottom"))
        sectionHeight = (windowsHeight - paddings)
      sectionHeight
    
    ###*
    Adds a css3 transform property to the container class with or without animation depending on the animated param.
    ###
    transformContainer = (translate3d, animated) ->
      addAnimation container, animated
      container.css getTransforms(translate3d)
      return
    
    ###*
    Scrolls to the given section and slide
    ###
    scrollPageAndSlide = (destiny, slide) ->
      slide = 0  if typeof slide is "undefined"
      if isNaN(destiny)
        section = $("[data-anchor=\"" + destiny + "\"]")
      else
        section = $(".fp-section").eq((destiny - 1))
      
      #we need to scroll to the section and then to the slide
      if destiny isnt lastScrolledDestiny and not section.hasClass("active")
        scrollPage section, ->
          scrollSlider section, slide
          return

      
      #if we were already in the section
      else
        scrollSlider section, slide
      return
    
    ###*
    Scrolls the slider to the given slide destination for the given section
    ###
    scrollSlider = (section, slide) ->
      unless typeof slide is "undefined"
        slides = section.find(".fp-slides")
        destiny = slides.find("[data-anchor=\"" + slide + "\"]")
        destiny = slides.find(".fp-slide").eq(slide)  unless destiny.length
        landscapeScroll slides, destiny  if destiny.length
      return
    
    ###*
    Creates a landscape navigation bar with dots for horizontal sliders.
    ###
    addSlidesNavigation = (section, numSlides) ->
      section.append "<div class=\"fp-slidesNav\"><ul></ul></div>"
      nav = section.find(".fp-slidesNav")
      
      #top or bottom
      nav.addClass options.slidesNavPosition
      i = 0

      while i < numSlides
        nav.find("ul").append "<li><a href=\"#\"><span></span></a></li>"
        i++
      
      #centering it
      nav.css "margin-left", "-" + (nav.width() / 2) + "px"
      nav.find("li").first().find("a").addClass "active"
      return
    
    ###*
    Sets the URL hash for a section with slides
    ###
    setURLHash = (slideIndex, slideAnchor, anchorLink, sectionIndex) ->
      sectionHash = ""
      if options.anchors.length
        
        #isn't it the first slide?
        if slideIndex
          sectionHash = anchorLink  if typeof anchorLink isnt "undefined"
          
          #slide without anchor link? We take the index instead.
          slideAnchor = slideIndex  if typeof slideAnchor is "undefined"
          lastScrolledSlide = slideAnchor
          location.hash = sectionHash + "/" + slideAnchor
        
        #first slide won't have slide anchor, just the section one
        else if typeof slideIndex isnt "undefined"
          lastScrolledSlide = slideAnchor
          location.hash = anchorLink
        
        #section without slides
        else
          location.hash = anchorLink
        setBodyClass location.hash
      else
        setBodyClass sectionIndex + "-" + slideIndex
      return
    
    ###*
    Sets a class for the body of the page depending on the active section / slide
    ###
    setBodyClass = (text) ->
      
      #changing slash for dash to make it a valid CSS style
      text = text.replace("/", "-").replace("#", "")
      
      #removing previous anchor classes
      $("body")[0].className = $("body")[0].className.replace(/\b\s?fp-viewing-.*\b/g, "")
      
      #adding the current anchor
      $("body").addClass "fp-viewing-" + text
      return
    
    ###*
    Checks for translate3d support
    @return boolean
    http://stackoverflow.com/questions/5661671/detecting-transform-translate3d-support
    ###
    support3d = ->
      el = document.createElement("p")
      has3d = undefined
      transforms =
        webkitTransform: "-webkit-transform"
        OTransform: "-o-transform"
        msTransform: "-ms-transform"
        MozTransform: "-moz-transform"
        transform: "transform"

      
      # Add it to the body to get the computed style.
      document.body.insertBefore el, null
      for t of transforms
        if el.style[t] isnt `undefined`
          el.style[t] = "translate3d(1px,1px,1px)"
          has3d = window.getComputedStyle(el).getPropertyValue(transforms[t])
      document.body.removeChild el
      has3d isnt `undefined` and has3d.length > 0 and has3d isnt "none"
    
    ###*
    Removes the auto scrolling action fired by the mouse wheel and tackpad.
    After this function is called, the mousewheel and trackpad movements won't scroll through sections.
    ###
    removeMouseWheelHandler = ->
      if document.addEventListener
        document.removeEventListener "mousewheel", MouseWheelHandler, false #IE9, Chrome, Safari, Oper
        document.removeEventListener "wheel", MouseWheelHandler, false #Firefox
      else
        document.detachEvent "onmousewheel", MouseWheelHandler #IE 6/7/8
      return
    
    ###*
    Adds the auto scrolling action for the mouse wheel and tackpad.
    After this function is called, the mousewheel and trackpad movements will scroll through sections
    ###
    addMouseWheelHandler = ->
      if document.addEventListener
        document.addEventListener "mousewheel", MouseWheelHandler, false #IE9, Chrome, Safari, Oper
        document.addEventListener "wheel", MouseWheelHandler, false #Firefox
      else
        document.attachEvent "onmousewheel", MouseWheelHandler #IE 6/7/8
      return
    
    ###*
    Adds the possibility to auto scroll through sections on touch devices.
    ###
    addTouchHandler = ->
      if isTouchDevice or isTouch
        
        #Microsoft pointers
        MSPointer = getMSPointer()
        $(document).off("touchstart " + MSPointer.down).on "touchstart " + MSPointer.down, touchStartHandler
        $(document).off("touchmove " + MSPointer.move).on "touchmove " + MSPointer.move, touchMoveHandler
      return
    
    ###*
    Removes the auto scrolling for touch devices.
    ###
    removeTouchHandler = ->
      if isTouchDevice or isTouch
        
        #Microsoft pointers
        MSPointer = getMSPointer()
        $(document).off "touchstart " + MSPointer.down
        $(document).off "touchmove " + MSPointer.move
      return
    
    #
    #   * Returns and object with Microsoft pointers (for IE<11 and for IE >= 11)
    #   * http://msdn.microsoft.com/en-us/library/ie/dn304886(v=vs.85).aspx
    #   
    getMSPointer = ->
      pointer = undefined
      
      #IE >= 11
      if window.PointerEvent
        pointer =
          down: "pointerdown"
          move: "pointermove"
      
      #IE < 11
      else
        pointer =
          down: "MSPointerDown"
          move: "MSPointerMove"
      pointer
    
    ###*
    Gets the pageX and pageY properties depending on the browser.
    https://github.com/alvarotrigo/fullPage.js/issues/194#issuecomment-34069854
    ###
    getEventsPage = (e) ->
      events = new Array()
      if window.navigator.msPointerEnabled
        events["y"] = e.pageY
        events["x"] = e.pageX
      else
        events["y"] = e.touches[0].pageY
        events["x"] = e.touches[0].pageX
      events
    silentLandscapeScroll = (activeSlide) ->
      prevScrollingSpeepd = options.scrollingSpeed
      $.fn.fullpage.setScrollingSpeed 0
      landscapeScroll activeSlide.closest(".fp-slides"), activeSlide
      $.fn.fullpage.setScrollingSpeed prevScrollingSpeepd
      return
    silentScroll = (top) ->
      if options.scrollBar
        container.scrollTop top
      else if options.css3
        translate3d = "translate3d(0px, -" + top + "px, 0px)"
        transformContainer translate3d, false
      else
        container.css "top", -top
      return
    getTransforms = (translate3d) ->
      "-webkit-transform": translate3d
      "-moz-transform": translate3d
      "-ms-transform": translate3d
      transform: translate3d
    
    #
    #   * Destroys fullpage.js plugin events and optinally its html markup and styles
    #   
    
    #lets make a mess!
    
    #
    #   * Removes inline styles added by fullpage.js
    #   
    destroyStructure = ->
      
      #reseting the `top` or `translate` properties to 0
      silentScroll 0
      $("#fp-nav, .fp-slidesNav, .fp-controlArrow").remove()
      
      #removing inline styles
      $(".fp-section").css
        height: ""
        "background-color": ""
        padding: ""

      $(".fp-slide").css width: ""
      container.css
        height: ""
        position: ""
        "-ms-touch-action": ""
        "touch-action": ""

      
      #removing added classes
      $(".fp-section, .fp-slide").each ->
        removeSlimScroll $(this)
        $(this).removeClass "fp-table active"
        return

      removeAnimation container
      removeAnimation container.find(".fp-easing")
      
      #Unwrapping content
      container.find(".fp-tableCell, .fp-slidesContainer, .fp-slides").each ->
        
        #unwrap not being use in case there's no child element inside and its just text
        $(this).replaceWith @childNodes
        return

      
      #scrolling the page to the top with no animation
      $("html, body").scrollTop 0
      return
    
    ###*
    Displays warnings
    ###
    displayWarnings = ->
      
      # Disable mutually exclusive settings
      if options.continuousVertical and (options.loopTop or options.loopBottom)
        options.continuousVertical = false
        showError "warn", "Option `loopTop/loopBottom` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"
      if options.continuousVertical and options.scrollBar
        options.continuousVertical = false
        showError "warn", "Option `scrollBar` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"
      
      #anchors can not have the same value as any element ID or NAME
      $.each options.anchors, (index, name) ->
        showError "error", "data-anchor tags can not have the same value as any `id` element on the site (or `name` element for IE)."  if $("#" + name).length or $("[name=\"" + name + "\"]").length
        return

      return
    showError = (type, text) ->
      console and console[type] and console[type]("fullPage: " + text)
      return
    options = $.extend(
      menu: false
      anchors: []
      navigation: false
      navigationPosition: "right"
      navigationColor: "#000"
      navigationTooltips: []
      slidesNavigation: false
      slidesNavPosition: "bottom"
      scrollBar: false
      css3: true
      scrollingSpeed: 700
      autoScrolling: true
      easing: "easeInQuart"
      easingcss3: "ease"
      loopBottom: false
      loopTop: false
      loopHorizontal: true
      continuousVertical: false
      normalScrollElements: null
      scrollOverflow: false
      touchSensitivity: 5
      normalScrollElementTouchThreshold: 5
      keyboardScrolling: true
      animateAnchor: true
      controlArrowColor: "#fff"
      verticalCentered: true
      resize: true
      sectionsColor: []
      paddingTop: 0
      paddingBottom: 0
      fixedElements: null
      responsive: 0
      sectionSelector: ".section"
      slideSelector: ".slide"
      afterLoad: null
      onLeave: null
      afterRender: null
      afterResize: null
      afterReBuild: null
      afterSlideLoad: null
      onSlideLeave: null
    , options)
    displayWarnings()
    scrollDelay = 600
    $.fn.fullpage.setAutoScrolling = (value) ->
      options.autoScrolling = value
      element = $(".fp-section.active")
      if options.autoScrolling and not options.scrollBar
        $("html, body").css
          overflow: "hidden"
          height: "100%"

        container.css
          "-ms-touch-action": "none"
          "touch-action": "none"

        silentScroll element.position().top  if element.length
      else
        $("html, body").css
          overflow: "visible"
          height: "initial"

        container.css
          "-ms-touch-action": ""
          "touch-action": ""

        silentScroll 0
        $("html, body").scrollTop element.position().top
      return

    $.fn.fullpage.setScrollingSpeed = (value) ->
      options.scrollingSpeed = value
      return

    $.fn.fullpage.setMouseWheelScrolling = (value) ->
      if value
        addMouseWheelHandler()
      else
        removeMouseWheelHandler()
      return

    $.fn.fullpage.setAllowScrolling = (value) ->
      if value
        $.fn.fullpage.setMouseWheelScrolling true
        addTouchHandler()
      else
        $.fn.fullpage.setMouseWheelScrolling false
        removeTouchHandler()
      return

    $.fn.fullpage.setKeyboardScrolling = (value) ->
      options.keyboardScrolling = value
      return

    $.fn.fullpage.moveSectionUp = ->
      prev = $(".fp-section.active").prev(".fp-section")
      prev = $(".fp-section").last()  if not prev.length and (options.loopTop or options.continuousVertical)
      scrollPage prev, null, true  if prev.length
      return

    $.fn.fullpage.moveSectionDown = ->
      next = $(".fp-section.active").next(".fp-section")
      next = $(".fp-section").first()  if not next.length and (options.loopBottom or options.continuousVertical)
      scrollPage next, null, false  if next.length
      return

    $.fn.fullpage.moveTo = (section, slide) ->
      destiny = ""
      if isNaN(section)
        destiny = $("[data-anchor=\"" + section + "\"]")
      else
        destiny = $(".fp-section").eq((section - 1))
      if typeof slide isnt "undefined"
        scrollPageAndSlide section, slide
      else scrollPage destiny  if destiny.length > 0
      return

    $.fn.fullpage.moveSlideRight = ->
      moveSlide "next"
      return

    $.fn.fullpage.moveSlideLeft = ->
      moveSlide "prev"
      return

    $.fn.fullpage.reBuild = (resizing) ->
      isResizing = true
      windowsWidth = $(window).width()
      windowsHeight = $(window).height()
      resizeMe windowsHeight, windowsWidth  if options.resize
      $(".fp-section").each ->
        scrollHeight = windowsHeight - parseInt($(this).css("padding-bottom")) - parseInt($(this).css("padding-top"))
        $(this).find(".fp-tableCell").css "height", getTableHeight($(this)) + "px"  if options.verticalCentered
        $(this).css "height", windowsHeight + "px"
        if options.scrollOverflow
          slides = $(this).find(".fp-slide")
          if slides.length
            slides.each ->
              createSlimScrolling $(this)
              return

          else
            createSlimScrolling $(this)
        slides = $(this).find(".fp-slides")
        landscapeScroll slides, slides.find(".fp-slide.active")  if slides.length
        return

      destinyPos = $(".fp-section.active").position()
      activeSection = $(".fp-section.active")
      scrollPage activeSection  if activeSection.index(".fp-section")
      isResizing = false
      $.isFunction(options.afterResize) and resizing and options.afterResize.call(this)
      $.isFunction(options.afterReBuild) and not resizing and options.afterReBuild.call(this)
      return

    slideMoving = false
    isTouchDevice = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry|BB10|Windows Phone|Tizen|Bada)/)
    isTouch = (("ontouchstart" of window) or (navigator.msMaxTouchPoints > 0) or (navigator.maxTouchPoints))
    container = $(this)
    windowsHeight = $(window).height()
    isMoving = false
    isResizing = false
    lastScrolledDestiny = undefined
    lastScrolledSlide = undefined
    nav = undefined
    wrapperSelector = "fullpage-wrapper"
    $.fn.fullpage.setAllowScrolling true
    options.css3 = support3d()  if options.css3
    if $(this).length
      container.css
        height: "100%"
        position: "relative"

      container.addClass wrapperSelector
    else
      showError "error", "Error! Fullpage.js needs to be initialized with a selector. For example: $('#myContainer').fullpage();"
    $(options.sectionSelector).each ->
      $(this).addClass "fp-section"
      return

    $(options.slideSelector).each ->
      $(this).addClass "fp-slide"
      return

    addVerticalNavigation()  if options.navigation
    $(".fp-section").each((index) ->
      that = $(this)
      slides = $(this).find(".fp-slide")
      numSlides = slides.length
      $(this).addClass "active"  if not index and $(".fp-section.active").length is 0
      $(this).css "height", windowsHeight + "px"
      $(this).css "padding", options.paddingTop + " 0 " + options.paddingBottom + " 0"  if options.paddingTop or options.paddingBottom
      $(this).css "background-color", options.sectionsColor[index]  if typeof options.sectionsColor[index] isnt "undefined"
      $(this).attr "data-anchor", options.anchors[index]  if typeof options.anchors[index] isnt "undefined"
      if numSlides > 1
        sliderWidth = numSlides * 100
        slideWidth = 100 / numSlides
        slides.wrapAll "<div class=\"fp-slidesContainer\" />"
        slides.parent().wrap "<div class=\"fp-slides\" />"
        $(this).find(".fp-slidesContainer").css "width", sliderWidth + "%"
        $(this).find(".fp-slides").after "<div class=\"fp-controlArrow fp-prev\"></div><div class=\"fp-controlArrow fp-next\"></div>"
        unless options.controlArrowColor is "#fff"
          $(this).find(".fp-controlArrow.fp-next").css "border-color", "transparent transparent transparent " + options.controlArrowColor
          $(this).find(".fp-controlArrow.fp-prev").css "border-color", "transparent " + options.controlArrowColor + " transparent transparent"
        $(this).find(".fp-controlArrow.fp-prev").hide()  unless options.loopHorizontal
        addSlidesNavigation $(this), numSlides  if options.slidesNavigation
        slides.each (index) ->
          $(this).css "width", slideWidth + "%"
          addTableClass $(this)  if options.verticalCentered
          return

        startingSlide = that.find(".fp-slide.active")
        if startingSlide.length is 0
          slides.eq(0).addClass "active"
        else
          silentLandscapeScroll startingSlide
      else
        addTableClass $(this)  if options.verticalCentered
      return
    ).promise().done ->
      $.fn.fullpage.setAutoScrolling options.autoScrolling
      activeSlide = $(".fp-section.active").find(".fp-slide.active")
      silentLandscapeScroll activeSlide  if activeSlide.length and ($(".fp-section.active").index(".fp-section") isnt 0 or ($(".fp-section.active").index(".fp-section") is 0 and activeSlide.index() isnt 0))
      $(options.fixedElements).appendTo "body"  if options.fixedElements and options.css3
      if options.navigation
        nav.css "margin-top", "-" + (nav.height() / 2) + "px"
        nav.find("li").eq($(".fp-section.active").index(".fp-section")).find("a").addClass "active"
      $(options.menu).appendTo "body"  if options.menu and options.css3 and $(options.menu).closest(".fullpage-wrapper").length
      if options.scrollOverflow
        createSlimScrollingHandler()  if document.readyState is "complete"
        $(window).on "load", createSlimScrollingHandler
      else
        $.isFunction(options.afterRender) and options.afterRender.call(this)
      responsive()
      value = window.location.hash.replace("#", "").split("/")
      destiny = value[0]
      if destiny.length
        section = $("[data-anchor=\"" + destiny + "\"]")
        if not options.animateAnchor and section.length
          if options.autoScrolling
            silentScroll section.position().top
          else
            silentScroll 0
            setBodyClass destiny
            $("html, body").scrollTop section.position().top
          activateMenuAndNav destiny, null
          $.isFunction(options.afterLoad) and options.afterLoad.call(this, destiny, (section.index(".fp-section") + 1))
          section.addClass("active").siblings().removeClass "active"
      $(window).on "load", ->
        scrollToAnchor()
        return

      return

    scrollId = undefined
    scrollId2 = undefined
    isScrolling = false
    $(window).on "scroll", scrollHandler
    touchStartY = 0
    touchStartX = 0
    touchEndY = 0
    touchEndX = 0
    $(window).on "hashchange", hashChangeHandler
    $(document).keydown (e) ->
      if options.keyboardScrolling and not isMoving and options.autoScrolling
        switch e.which
          when 38, 33
            $.fn.fullpage.moveSectionUp()
          when 40, 34
            $.fn.fullpage.moveSectionDown()
          when 36
            $.fn.fullpage.moveTo 1
          when 35
            $.fn.fullpage.moveTo $(".fp-section").length
          when 37
            $.fn.fullpage.moveSlideLeft()
          when 39
            $.fn.fullpage.moveSlideRight()
          else
            return

    $(document).on "click touchstart", "#fp-nav a", (e) ->
      e.preventDefault()
      index = $(this).parent().index()
      scrollPage $(".fp-section").eq(index)
      return

    $(document).on "click touchstart", ".fp-slidesNav a", (e) ->
      e.preventDefault()
      slides = $(this).closest(".fp-section").find(".fp-slides")
      destiny = slides.find(".fp-slide").eq($(this).closest("li").index())
      landscapeScroll slides, destiny
      return

    if options.normalScrollElements
      $(document).on "mouseenter", options.normalScrollElements, ->
        $.fn.fullpage.setMouseWheelScrolling false
        return

      $(document).on "mouseleave", options.normalScrollElements, ->
        $.fn.fullpage.setMouseWheelScrolling true
        return

    $(".fp-section").on "click touchstart", ".fp-controlArrow", ->
      if $(this).hasClass("fp-prev")
        $.fn.fullpage.moveSlideLeft()
      else
        $.fn.fullpage.moveSlideRight()
      return

    $(window).resize resizeHandler
    previousHeight = windowsHeight
    resizeId = undefined
    $.fn.fullpage.destroy = (all) ->
      $.fn.fullpage.setAutoScrolling false
      $.fn.fullpage.setAllowScrolling false
      $.fn.fullpage.setKeyboardScrolling false
      $(window).off("scroll", scrollHandler).off("hashchange", hashChangeHandler).off "resize", resizeHandler
      $(document).off("click", "#fp-nav a").off("mouseenter", "#fp-nav li").off("mouseleave", "#fp-nav li").off("click", ".fp-slidesNav a").off("mouseover", options.normalScrollElements).off "mouseout", options.normalScrollElements
      $(".fp-section").off "click", ".fp-controlArrow"
      destroyStructure()  if all
      return

    return

  return
) jQuery