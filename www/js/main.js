(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var BasePage;BasePage=function(){function t(t){var e;this.container=t,this.offset=0,this.shown=!1,e=document.querySelector(this.container),null!=e&&(this.offset=Number(e.getAttribute("data-scroll-offset")))}return t.prototype.show=function(){return this.animationClass.show()},t.prototype.hide=function(){return this.animationClass.hide()},t}(),module.exports=BasePage;
//# sourceMappingURL=out.js.map

},{}],2:[function(require,module,exports){
var PagesTypes;PagesTypes=function(){function e(){console.log("this object does not be called by its instance")}return e.TRANSILIENS="transiliens",e.COFFEE="coffee",e.CLOCK="clock",e.TEETH="teeth",e.SOLUTION="solutionToU",e.TRAVEL="travel",e.SAVING="saving",e.DATA="data",e}(),module.exports=PagesTypes;
//# sourceMappingURL=out.js.map

},{}],3:[function(require,module,exports){
var PagesTypes,ScrollManager,ScrollManagerSingleton,__bind=function(e,s){return function(){return e.apply(s,arguments)}},__hasProp={}.hasOwnProperty,__extends=function(e,s){function i(){this.constructor=e}for(var t in s)__hasProp.call(s,t)&&(e[t]=s[t]);return i.prototype=s.prototype,e.prototype=new i,e.__super__=s.prototype,e};PagesTypes=require("./PagesTypes"),ScrollManagerSingleton=function(){function e(){}var s;return s=null,e.get=function(){return null!=s?s:s=new this},e}(),ScrollManager=function(e){function s(){this.arrowClicked=__bind(this.arrowClicked,this),this.keyControl=__bind(this.keyControl,this),this.scroll=__bind(this.scroll,this),this.index=-1,this.pagesOffsets=[],this.keyArray=[PagesTypes.TRANSILIENS,PagesTypes.COFFEE,PagesTypes.CLOCK,PagesTypes.TEETH,PagesTypes.SOLUTION,PagesTypes.TRAVEL,PagesTypes.SAVING,PagesTypes.DATA],this.i=0,this.numberKeys=0,this.isFirstScroll=!0,this.preventScroll=!1}return __extends(s,e),s.prototype.addPages=function(e,s){var i,t,n;this.pages=e,this.i=s,n=this.pages;for(i in n)t=n[i],null!=t.offset&&this.pagesOffsets.push(t.offset);for(window.addEventListener("mousewheel",this.scroll,!1),window.addEventListener("keydown",this.keyControl,!1),this.classname=document.getElementsByClassName("arrow"),s=0;s<this.classname.length-1;)this.classname[s].addEventListener("click",this.arrowClicked,!1),s++;return this.scroll()},s.prototype.scroll=function(e){var s,i;if(null==e&&(e=null),!this.preventScroll){if(this.preventScroll=!0,window.setTimeout(function(e){return function(){return e.preventScroll=!1}}(this),2e3),e=window.event||e,s=Math.max(-1,Math.min(1,e.wheelDelta||-e.detail)),console.log("               delta",s),console.log("index",this.index),this.isFirstScroll){this.index=this.i,this.pages[this.keyArray[this.index]].show(),console.log("index first",this.index);for(i in this.pages)this.numberKeys++}else console.log("else"),console.log("number",this.numberKeys),-1===s&&this.index<this.numberKeys-1&&(console.log("DOWN"),this.pages[this.keyArray[this.index]].hide(),this.i++,this.index=this.i,console.log("index after down",this.index),this.pages[this.keyArray[this.index]].show()),1===s&&0!==this.index&&(this.pages[this.keyArray[this.index]].hide(),this.i--,this.index=this.i,this.pages[this.keyArray[this.index]].show(),console.log("UP"));return this.isFirstScroll=!1}},s.prototype.keyControl=function(e){return null==e&&(e=null),e=window.event||e,40===e.keyCode&&(console.log("DOWN key"),this.index<this.numberKeys-1&&(this.pages[this.keyArray[this.index]].hide(),this.i++,this.index=this.i,this.pages[this.keyArray[this.index]].show())),38===e.keyCode&&(console.log("UP key"),0!==this.index)?(this.pages[this.keyArray[this.index]].hide(),this.i--,this.index=this.i,this.pages[this.keyArray[this.index]].show()):void 0},s.prototype.arrowClicked=function(){return console.log("ARROW CLICK"),this.pages[this.keyArray[this.index]].hide(),this.i++,this.index=this.i,this.pages[this.keyArray[this.index]].show()},s}(ScrollManagerSingleton),module.exports=ScrollManager;
//# sourceMappingURL=out.js.map

},{"./PagesTypes":2}],4:[function(require,module,exports){
var App,PagesTypes,app;PagesTypes=require("./PagesTypes"),App=function(){function e(){var e;console.log("[APP]"),this.scrollManager=require("./ScrollManager").get(),this.pages={},this.pages[PagesTypes.TRANSILIENS]=new(require("./pages/TransiliensPage")),this.pages[PagesTypes.COFFEE]=new(require("./pages/CoffeePage")),this.pages[PagesTypes.CLOCK]=new(require("./pages/ClockPage")),this.pages[PagesTypes.TEETH]=new(require("./pages/TeethPage")),this.pages[PagesTypes.SOLUTION]=new(require("./pages/SolutionPage")),this.pages[PagesTypes.TRAVEL]=new(require("./pages/TravelPage")),this.pages[PagesTypes.SAVING]=new(require("./pages/SavingPage")),this.pages[PagesTypes.DATA]=new(require("./pages/DataPage")),this.gare,this.realHour,this.numberPeopleInHour,this.numberTotalPassenger,this.percentPerson,this.percentAffluence,this.percentSaving,this.percentStress,this.affluenceImg,this.savingImg,this.stressImg,this.scrollManager.addPages(this.pages,this.scrollManager.i),window.scrollTop=0,$(function(){$("select#valueA").selectToUISlider({labels:9,sliderOptions:{change:function(){}}})}),e=new XMLHttpRequest,e.open("GET","http://anarchy.rayanmestiri.com/ecs-name/all",!0),e.onload=function(){var n,t,r,s,a,o;for(n=JSON.parse(e.response),o=[],$.each(n,function(e,n){return o.push({ecs:e,name:n})}),t=0,r=[];t<o.length;)r.push(o[t].name),t++;s=document.getElementById("autocomplete__field"),a=completely(s,{fontSize:"10px",promptInnerHTML:""}),a.options=r,a.hideDropDown(),a.onChange=function(){return a.hideDropDown(),a.startFrom=0,a.repaint(),this.valueText=a.input.value},a.input.maxLength=50,a.hideDropDown()},e.send(),$(".ok").click(function(n){return function(){return e=new XMLHttpRequest,e.open("GET","http://anarchy.rayanmestiri.com/ecs-name/all",!1),e.onreadystatechange=function(){var t,r,s,a,o,p,c;for(t=JSON.parse(e.response),p=[],$.each(t,function(e,n){return p.push({ecs:e,name:n})}),s=0;s<p.length;)p[s].name===$(".textInput").val()&&(n.gare=p[s].ecs,a=new RegExp("[ :]+","g"),c=$("select#valueA").val().split(a),console.log(parseInt(c[0])),r=parseInt(c[0]),10>r?(n.realHour="0"+r,console.log("REAL HOUR",n.realHour)):n.realHour=r),s++;return 4===e.readyState&&200===e.status?(console.log("SUCESS"),o=new XMLHttpRequest,o.open("GET","http://anarchy.rayanmestiri.com/ecs-time/"+n.gare+"/"+n.realHour,!1),o.onreadystatechange=function(){var e;return n.numberPeopleInHour=JSON.parse(o.response),4===o.readyState&&200===o.status?(e=new XMLHttpRequest,e.open("GET","http://anarchy.rayanmestiri.com/ecs/"+n.gare,!1),e.onreadystatechange=function(){return n.numberTotalPassenger=JSON.parse(e.response)},e.send()):void 0},o.send()):void 0},e.send(),console.log("at the end",n.numberPeopleInHour,"  ",n.numberTotalPassenger," percent : ",Math.round(n.numberPeopleInHour/n.numberTotalPassenger*100)),n.percentPerson=Math.round(n.numberPeopleInHour/n.numberTotalPassenger*100),n.numberTotalPassenger>1e4&&(n.easingSwitchLotPeople=Math.round(0+4*Math.random()+1)),n.numberTotalPassenger>2e4&&(n.easingSwitchLotPeople=Math.round(0+6*Math.random()+4)),n.numberTotalPassenger>4e4&&(n.easingSwitchLotPeople=Math.round(0+12*Math.random()+8)),n.numberTotalPassenger>5e4&&(n.easingSwitchLotPeople=Math.round(0+30*Math.random()+20)),n.percentPerson<=8&&(n.percentAffluence=Math.round(n.percentPerson)+n.easingSwitchLotPeople,n.percentSaving=50,n.percentStress=Math.round(0+6*Math.random()+2)+n.easingSwitchLotPeople),n.percentPerson>8&&(n.percentAffluence=Math.round(2.15*n.percentPerson)+n.easingSwitchLotPeople,n.percentSaving=20,n.percentStress=Math.round(2.33*n.percentPerson+6*Math.random()+2)+n.easingSwitchLotPeople),n.percentPerson>10&&(n.percentAffluence=Math.round(2.15*n.percentPerson)+n.easingSwitchLotPeople,n.percentSaving=5,n.percentStress=Math.round(2.33*n.percentPerson+6*Math.random()+2)+n.easingSwitchLotPeople),n.percentPerson>15&&(n.percentAffluence=3*n.percentPerson+n.easingSwitchLotPeople,n.percentSaving=0,n.percentStress=Math.round(5*n.percentPerson+25*Math.random()+15)+n.easingSwitchLotPeople),n.affluenceImg=function(){var e,n;switch(!1){case!(0<=(e=this.percentAffluence)&&20>e):return 1;case!(20<=(n=this.percentAffluence)&&50>n):return 2;case!(50<=this.percentAffluence):return 3}}.call(n),n.savingImg=function(){var e,n;switch(!1){case!(0<=(e=this.percentSaving)&&20>e):return 1;case!(20<=(n=this.percentSaving)&&50>n):return 2;case!(50<=this.percentSaving):return 3}}.call(n),n.stressImg=function(){var e,n;switch(!1){case!(0<=(e=this.percentStress)&&20>e):return 1;case!(20<=(n=this.percentStress)&&50>n):return 2;case!(50<=this.percentStress):return 3}}.call(n),console.log("affluence : ",n.percentAffluence," saving : ",n.percentSaving," stress : ",n.percentStress),n.pages[PagesTypes.DATA].updatePercent(n.percentAffluence,n.percentSaving,n.percentStress),n.pages[PagesTypes.DATA].updateImg(n.affluenceImg,n.savingImg,n.stressImg)}}(this))}return e.prototype.resize=function(){},e}(),app=null,document.addEventListener("DOMContentLoaded",function(){return function(){return app=new App,window.addEventListener("resize",function(){return app.resize()},!1)}}(this));
//# sourceMappingURL=out.js.map

},{"./PagesTypes":2,"./ScrollManager":3,"./pages/ClockPage":5,"./pages/CoffeePage":6,"./pages/DataPage":7,"./pages/SavingPage":8,"./pages/SolutionPage":9,"./pages/TeethPage":10,"./pages/TransiliensPage":11,"./pages/TravelPage":12}],5:[function(require,module,exports){
var BasePage,ClockPage,__hasProp={}.hasOwnProperty,__extends=function(e,o){function t(){this.constructor=e}for(var n in o)__hasProp.call(o,n)&&(e[n]=o[n]);return t.prototype=o.prototype,e.prototype=new t,e.__super__=o.prototype,e};BasePage=require("../BasePage"),ClockPage=function(e){function o(){this.container=".clock",o.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/ClockAnimationPage"))(this.container),console.log("[ClockPage]")}return __extends(o,e),o.prototype.show=function(){return o.__super__.show.call(this)},o.prototype.hide=function(){return o.__super__.hide.call(this)},o}(BasePage),module.exports=ClockPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/ClockAnimationPage":13}],6:[function(require,module,exports){
var BasePage,CoffeePage,__hasProp={}.hasOwnProperty,__extends=function(e,o){function t(){this.constructor=e}for(var n in o)__hasProp.call(o,n)&&(e[n]=o[n]);return t.prototype=o.prototype,e.prototype=new t,e.__super__=o.prototype,e};BasePage=require("../BasePage"),CoffeePage=function(e){function o(){this.container=".coffee",o.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/CoffeeAnimationPage"))(this.container),console.log("[CoffeePage]")}return __extends(o,e),o.prototype.show=function(){return o.__super__.show.call(this)},o.prototype.hide=function(){return o.__super__.hide.call(this)},o}(BasePage),module.exports=CoffeePage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/CoffeeAnimationPage":14}],7:[function(require,module,exports){
var BasePage,DataPage,__hasProp={}.hasOwnProperty,__extends=function(t,e){function a(){this.constructor=t}for(var s in e)__hasProp.call(e,s)&&(t[s]=e[s]);return a.prototype=e.prototype,t.prototype=new a,t.__super__=e.prototype,t};BasePage=require("../BasePage"),DataPage=function(t){function e(){this.container=".data",e.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/DataAnimationPage"))(this.container),console.log("[DataPage]")}return __extends(e,t),e.prototype.show=function(){return e.__super__.show.call(this)},e.prototype.hide=function(){return e.__super__.hide.call(this)},e.prototype.updatePercent=function(t,e,a){return this.affluence=t,this.saving=e,this.stress=a,console.log("[DataPage update]"),this.animationClass.updatePercent(this.affluence,this.saving,this.stress)},e.prototype.updateImg=function(t,e,a){return this.affluence=t,this.saving=e,this.stress=a,console.log("[DataPage img]"),this.animationClass.updateImg(this.affluence,this.saving,this.stress)},e}(BasePage),module.exports=DataPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/DataAnimationPage":15}],8:[function(require,module,exports){
var BasePage,SavingPage,__hasProp={}.hasOwnProperty,__extends=function(e,t){function n(){this.constructor=e}for(var o in t)__hasProp.call(t,o)&&(e[o]=t[o]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e};BasePage=require("../BasePage"),SavingPage=function(e){function t(){this.container=".saving",t.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/SavingAnimationPage"))(this.container),console.log("[SavingPage]")}return __extends(t,e),t.prototype.show=function(){return t.__super__.show.call(this)},t.prototype.hide=function(){return t.__super__.hide.call(this)},t}(BasePage),module.exports=SavingPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/SavingAnimationPage":16}],9:[function(require,module,exports){
var BasePage,SolutionPage,__hasProp={}.hasOwnProperty,__extends=function(o,t){function e(){this.constructor=o}for(var n in t)__hasProp.call(t,n)&&(o[n]=t[n]);return e.prototype=t.prototype,o.prototype=new e,o.__super__=t.prototype,o};BasePage=require("../BasePage"),SolutionPage=function(o){function t(){this.container=".solutionToU",t.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/SolutionAnimationPage"))(this.container),console.log("[SolutionPage]")}return __extends(t,o),t.prototype.show=function(){return t.__super__.show.call(this)},t.prototype.hide=function(){return t.__super__.hide.call(this)},t}(BasePage),module.exports=SolutionPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/SolutionAnimationPage":17}],10:[function(require,module,exports){
var BasePage,TeethPage,__hasProp={}.hasOwnProperty,__extends=function(e,t){function o(){this.constructor=e}for(var n in t)__hasProp.call(t,n)&&(e[n]=t[n]);return o.prototype=t.prototype,e.prototype=new o,e.__super__=t.prototype,e};BasePage=require("../BasePage"),TeethPage=function(e){function t(){this.container=".teeth",t.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/TeethAnimationPage"))(this.container),console.log("[TeethPage]")}return __extends(t,e),t.prototype.show=function(){return t.__super__.show.call(this)},t.prototype.hide=function(){return t.__super__.hide.call(this)},t}(BasePage),module.exports=TeethPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/TeethAnimationPage":18}],11:[function(require,module,exports){
var BasePage,TransiliensPage,__hasProp={}.hasOwnProperty,__extends=function(e,n){function t(){this.constructor=e}for(var r in n)__hasProp.call(n,r)&&(e[r]=n[r]);return t.prototype=n.prototype,e.prototype=new t,e.__super__=n.prototype,e};BasePage=require("../BasePage"),TransiliensPage=function(e){function n(){this.container=".transiliens",n.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/TransiliensAnimationPage"))(this.container),console.log("[TransiliensPage]")}return __extends(n,e),n.prototype.show=function(){return n.__super__.show.call(this)},n.prototype.hide=function(){return n.__super__.hide.call(this)},n}(BasePage),module.exports=TransiliensPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/TransiliensAnimationPage":19}],12:[function(require,module,exports){
var BasePage,TravelPage,__hasProp={}.hasOwnProperty,__extends=function(e,t){function r(){this.constructor=e}for(var o in t)__hasProp.call(t,o)&&(e[o]=t[o]);return r.prototype=t.prototype,e.prototype=new r,e.__super__=t.prototype,e};BasePage=require("../BasePage"),TravelPage=function(e){function t(){this.container=".travel",t.__super__.constructor.call(this,this.container),this.animationClass=new(require("./animations/TravelAnimationPage"))(this.container),console.log("[TravelPage]")}return __extends(t,e),t.prototype.show=function(){return t.__super__.show.call(this)},t.prototype.hide=function(){return t.__super__.hide.call(this)},t}(BasePage),module.exports=TravelPage;
//# sourceMappingURL=out.js.map

},{"../BasePage":1,"./animations/TravelAnimationPage":20}],13:[function(require,module,exports){
var ClockAnimationPage;ClockAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h6=""+this.container+" h6",this.arrow=""+this.container+" .arrow",this.shapes=""+this.container+" path",this.svg=""+this.container+" .clock__svg",this.path0=""+this.container+" #clockPath0",this.path1=""+this.container+" #clockPath1",this.path2=""+this.container+" #clockPath2",this.path3=""+this.container+" #clockPath3",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set(this.container,{autoAlpha:0}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h6,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100})},t.prototype.show=function(){var t,a,e,s,i;return i=0,this.tm=new TimelineMax({paused:!0}),s=new SplitText(this.h6,{type:"words,chars"}),a=s.chars,e=new SplitText(this.h2,{type:"words,chars"}),t=e.chars,this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=4.5),this.tm.staggerFrom(a,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% 50% -50",ease:Back.easeOut},.01,i+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"réveil",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.3),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.staggerFromTo(this.shapes,1,{drawSVG:"50% 50%"},{drawSVG:"100%"},.3,i+=.1).staggerTo(this.shapes,.5,{stroke:"none",scale:1,opacity:0},.4,i+=.4),this.tm.to(this.path0,.5,{fill:"#BA1543",scale:1,opacity:1},i+=.5),this.tm.to(this.path1,.5,{fill:"#F0F5E3",scale:1,opacity:1},i+=.5),this.tm.to(this.path2,.5,{fill:"#F0F5E3",scale:1,opacity:1},i+=.5),this.tm.to(this.path3,.5,{fill:"#F0F5E3",scale:1,opacity:1},i+=.5),this.tm.to(this.h6,.3,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.3),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=ClockAnimationPage;
//# sourceMappingURL=out.js.map

},{}],14:[function(require,module,exports){
var CoffeeAnimationPage;CoffeeAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h6=""+this.container+" h6",this.arrow=""+this.container+" .arrow",this.shapes=""+this.container+" path",this.svg=""+this.container+" .coffee__svg",this.spoon=""+this.container+" .spoon",this.drop1=""+this.container+" .drop1",this.drop2=""+this.container+" .drop2",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set([this.container,this.img,this.drop1,this.drop2],{autoAlpha:0}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h6,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100}),TweenMax.set(this.spoon,{autoAlpha:0,y:-800,rotation:-30}),TweenMax.set(this.drop2,{y:50,x:100}),TweenMax.set(this.drop2,{y:50,x:50})},t.prototype.show=function(){var t,e,s,a,i;return i=0,this.tm=new TimelineMax({paused:!0}),a=new SplitText(this.h6,{type:"words,chars"}),e=a.chars,s=new SplitText(this.h2,{type:"words,chars"}),t=s.chars,this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=.2),this.tm.staggerFrom(e,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% 50% -50",ease:Back.easeOut},.01,i+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"café",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.3),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.staggerFromTo(this.shapes,1,{drawSVG:"50% 50%"},{drawSVG:"100%"},.3,i+=.1).staggerTo(this.shapes,.5,{stroke:"none",scale:1,opacity:0},.4,i+=.4).staggerTo(this.shapes,.5,{fill:"#EFEEEC",scale:1,opacity:1},.2,i+=.5),this.tm.to(this.spoon,1.5,{autoAlpha:1,y:-15,rotation:700,ease:Ease.easeOut},i+=.4),this.tm.to(this.drop2,.6,{autoAlpha:1,y:0,x:0,ease:Ease.easeOut},i+=1.3),this.tm.to(this.drop1,.3,{autoAlpha:1,y:0,x:0,ease:Ease.easeOut},i+=.3),this.tm.to(this.h6,.3,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.3),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.spoon,1.5,{y:15,x:-15,rotation:720,ease:Ease.easeOut},i+=1.5),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=CoffeeAnimationPage;
//# sourceMappingURL=out.js.map

},{}],15:[function(require,module,exports){
var DataAnimationPage;DataAnimationPage=function(){function e(e){this.container=e,this.container=""+this.container,this.h4Direction=""+this.container+" .direction",this.h2=""+this.container+" .selected--line",this.line=""+this.container+" line--number",this.h3=""+this.container+" h3",this.h5=""+this.container+" h5",this.selectBoxChoose=""+this.container+" .select__box .choose",this.selectBoxOk=""+this.container+" .select__box .ok",this.selectBoxLI=""+this.container+" .select__box li",this.selectBoxTitle=""+this.container+" .select__box li.title",this.h2Affluence=""+this.container+" .impact--affluence  h2.impact--subtitle",this.h2Saving=""+this.container+" .impact--saving  h2.impact--subtitle",this.h2Stress=""+this.container+" .impact--stress  h2.impact--subtitle",this.h2AffluenceCount=""+this.container+" .impact--affluence  h2.count",this.h2SavingCount=""+this.container+" .impact--saving  h2.count",this.h2StressCount=""+this.container+" .impact--stress  h2.count",this.AffluenceImg=""+this.container+" .impact--affluence  img",this.SavingImg=""+this.container+" .impact--saving  img",this.StressImg=""+this.container+" .impact--stress  img",this.prepare()}return e.prototype.prepare=function(){return TweenMax.set(this.container,{autoAlpha:0}),TweenMax.set(this.h4Direction,{perspective:400},{autoAlpha:0}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.line,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h5,{autoAlpha:0,y:200}),TweenMax.set(this.selectBoxChoose,{autoAlpha:0}),TweenMax.set(this.selectBoxOk,{autoAlpha:0}),TweenMax.set(this.selectBoxTitle,{autoAlpha:0}),TweenMax.set(this.selectBoxLI,{autoAlpha:0}),TweenMax.set(this.h2Affluence,{autoAlpha:0}),TweenMax.set(this.h2Saving,{autoAlpha:0}),TweenMax.set(this.h2Stress,{autoAlpha:0}),TweenMax.set([this.AffluenceImg,this.SavingImg,this.StressImg],{autoAlpha:0}),TweenMax.set(this.AffluenceImg,{x:-300}),TweenMax.set(this.StressImg,{x:300}),TweenMax.set(this.SavingImg,{y:-100})},e.prototype.show=function(){var e,t,s,a,i;return i=0,this.tm=new TimelineMax({paused:!0}),s=new SplitText(this.h2,{type:"words,chars"}),e=s.chars,a=new SplitText(this.h4Direction,{type:"words,chars"}),t=a.chars,this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=.2),this.tm.staggerFrom(e,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"100% 50% 50",ease:Back.easeOut},.01,i+=.2),this.tm.to(this.selectBoxChoose,1,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.selectBoxOk,1,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.selectBoxLI,1,{autoAlpha:0,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.selectBoxTitle,1,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h5,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h2Affluence,1,{autoAlpha:1,scrambleText:{text:"Affluence ",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.h2Saving,1,{autoAlpha:1,scrambleText:{text:"Economie ",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.h2Stress,1,{autoAlpha:1,scrambleText:{text:"Stress ",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.h2AffluenceCount,1,{autoAlpha:1,scrambleText:{text:"---",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.h2SavingCount,1,{autoAlpha:1,scrambleText:{text:"---",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.h2StressCount,1,{autoAlpha:1,scrambleText:{text:"---",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.5),this.tm.to(this.AffluenceImg,1,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.1),this.tm.to(this.StressImg,1,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.1),this.tm.to(this.SavingImg,1,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.1),this.tm.play()},e.prototype.hide=function(){return this.tm.reverse()},e.prototype.updatePercent=function(e,t,s){var a;return this.affluence=e,this.saving=t,this.stress=s,console.log("UPDATE PERCENT"),a=0,this.tm=new TimelineMax({paused:!0}),this.tm.to(this.h2AffluenceCount,1,{autoAlpha:1,scrambleText:{text:this.affluence+"%",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},a+=.5),this.tm.to(this.h2SavingCount,1,{autoAlpha:1,scrambleText:{text:"-"+this.saving+"%",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},a+=.5),this.tm.to(this.h2StressCount,1,{autoAlpha:1,scrambleText:{text:"+"+this.stress+"%",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},a+=.5),this.tm.play()},e.prototype.updateImg=function(e,t,s){var a;return this.affluence=e,this.saving=t,this.stress=s,console.log("UPDATE IMG"),this.affluenceShow=""+this.AffluenceImg+".afflu-"+this.affluence,this.savingShow=""+this.SavingImg+".eco-"+this.saving,this.stressShow=""+this.StressImg+".stress-"+this.stress,console.log(this.affluenceShow),a=0,this.tm=new TimelineMax({paused:!0}),this.tm.to([this.AffluenceImg,this.StressImg,this.SavingImg],.2,{autoAlpha:0,ease:Ease.easeIn},a+=.2),this.tm.to([this.affluenceShow,this.savingShow,this.stressShow],.2,{autoAlpha:1,x:-2,ease:Ease.easeIn},a+=.2),this.tm.to([this.affluenceShow,this.savingShow,this.stressShow],.2,{x:2,ease:Ease.easeIn},a+=.2),this.tm.to([this.affluenceShow,this.savingShow,this.stressShow],.2,{x:-2,ease:Ease.easeIn},a+=.2),this.tm.to([this.affluenceShow,this.savingShow,this.stressShow],.2,{x:0,ease:Ease.easeIn},a+=.2),this.tm.play()},e}(),module.exports=DataAnimationPage;
//# sourceMappingURL=out.js.map

},{}],16:[function(require,module,exports){
var SavingAnimationPage;SavingAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.h2=""+this.container+" h2",this.line=""+this.container+" line--number",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h5=""+this.container+" h5",this.arrow=""+this.container+" .arrow",this.p=""+this.container+" p",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set(this.container,{autoAlpha:0}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.line,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h5,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100}),TweenMax.set(this.p,{perspective:400})},t.prototype.show=function(){var t,e,a,i,s;return i=0,this.tm=new TimelineMax({paused:!0}),e=new SplitText(this.h2,{type:"words,chars"}),t=e.chars,a=new SplitText(this.p,{type:"words"}),s=a.words,this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"Economies ",chars:"Good job girl",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=1.5),this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=.2),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h5,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.staggerFrom(s,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"100% 200% 0",ease:Back.easeOut},.01,i+=.5),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=SavingAnimationPage;
//# sourceMappingURL=out.js.map

},{}],17:[function(require,module,exports){
var SolutionAnimationPage;SolutionAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.arrow=""+this.container+" .arrow",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set(this.h1,{x:0}),TweenMax.set(this.h2,{x:0}),TweenMax.set(this.h3,{x:0}),TweenMax.set(this.container,{autoAlpha:0}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.arrow,{autoAlpha:0,x:100})},t.prototype.show=function(){var t,e,a;return a=0,this.tm=new TimelineMax({paused:!0}),e=new SplitText(this.h2,{type:"words,chars"}),t=e.chars,this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"solutions",chars:"Nique la sncf",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},a+=.3),this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},a+=.2),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,a+=.8),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},a+=.2),this.tm.to(this.arrow,.8,{autoAlpha:1,x:0,ease:Back.easeOut},a+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=SolutionAnimationPage;
//# sourceMappingURL=out.js.map

},{}],18:[function(require,module,exports){
var TeethAnimationPage;TeethAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h6=""+this.container+" h6",this.arrow=""+this.container+" .arrow",this.img=""+this.container+"   .toothpaste",this.shapes=""+this.container+" path",this.svg=""+this.container+" .teeth__svg",this.path0=""+this.container+" #teethPath0",this.path1=""+this.container+" #teethPath1",this.path2=""+this.container+" #teethPath2",this.path3=""+this.container+" #teethPath3",this.path4=""+this.container+" #teethPath4",this.path5=""+this.container+" #teethPath5",this.path6=""+this.container+" #teethPath6",this.path7=""+this.container+" #teethPath7",this.path8=""+this.container+" #teethPath8",this.path9=""+this.container+" #teethPath9",this.path10=""+this.container+" #teethPath10",this.path11=""+this.container+" #teethPath11",this.path12=""+this.container+" #teethPath12",this.path13=""+this.container+" #teethPath13",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set([this.container,this.img],{autoAlpha:0}),TweenMax.set(this.img,{x:300}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h6,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100})},t.prototype.show=function(){var t,h,a,i,e;return e=0,this.tm=new TimelineMax({paused:!0}),i=new SplitText(this.h6,{type:"words,chars"}),h=i.chars,a=new SplitText(this.h2,{type:"words,chars"}),t=a.chars,this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},e+=4.5),this.tm.staggerFrom(h,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% 50% -50",ease:Back.easeOut},.01,e+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,e+=.8),this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"brosse à dents",chars:"0123456789",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},e+=.3),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},e+=.2),this.tm.staggerFromTo(this.shapes,1,{drawSVG:"50% 50%"},{drawSVG:"100%"},.3,e+=.1).staggerTo(this.shapes,.5,{stroke:"none",scale:1,opacity:0},.4,e+=.4),this.tm.to(this.path0,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path1,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path2,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path3,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path4,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path5,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path6,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path7,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path8,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path9,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path10,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path11,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path12,.2,{fill:"#F2F4F4",scale:1,opacity:1},e+=.4),this.tm.to(this.path13,.2,{fill:"#214E61",scale:1,opacity:1},e+=.4),this.tm.to(this.img,.3,{autoAlpha:1,x:0,ease:Back.easeOut},e+=.3),this.tm.to(this.h6,.3,{autoAlpha:1,y:0,ease:Back.easeOut},e+=.3),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},e+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=TeethAnimationPage;
//# sourceMappingURL=out.js.map

},{}],19:[function(require,module,exports){
var TransiliensAnimationPage;TransiliensAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.img=""+this.container+" img",this.h4=""+this.container+" h4",this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h5=""+this.container+" h5",this.arrow=""+this.container+" .arrow",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set([this.container,this.img],{autoAlpha:0}),TweenMax.set(this.img,{x:-5e3,scale:"50%"}),TweenMax.set(this.h4,{perspective:400}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h5,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100})},t.prototype.show=function(){var t,e,a,s,i;return i=0,this.tm=new TimelineMax({paused:!0}),s=new SplitText(this.h4,{type:"words,chars"}),e=s.chars,a=new SplitText(this.h2,{type:"words,chars"}),t=a.chars,this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"transiliens",chars:"Nique la sncf",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=.3),this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=.2),this.tm.to(this.img,1,{autoAlpha:1,x:0,scale:1,ease:Ease.easeIn},i+=.2),this.tm.staggerFrom(e,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% 50% -50",ease:Back.easeOut},.01,i+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h5,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=TransiliensAnimationPage;
//# sourceMappingURL=out.js.map

},{}],20:[function(require,module,exports){
var TravelAnimationPage;TravelAnimationPage=function(){function t(t){this.container=t,this.container=""+this.container,this.img=""+this.container+" img",this.h4=""+this.container+" h4",this.h2=""+this.container+" h2",this.h1=""+this.container+" h1",this.h3=""+this.container+" h3",this.h5=""+this.container+" h5",this.arrow=""+this.container+" .arrow",this.prepare()}return t.prototype.prepare=function(){return TweenMax.set([this.container,this.img],{autoAlpha:0}),TweenMax.set(this.img,{x:-5e3,scale:"50%"}),TweenMax.set(this.h4,{perspective:400}),TweenMax.set(this.h2,{perspective:400}),TweenMax.set(this.h1,{autoAlpha:0}),TweenMax.set(this.h3,{autoAlpha:0,x:200}),TweenMax.set(this.h5,{autoAlpha:0,y:200}),TweenMax.set(this.arrow,{autoAlpha:0,y:-100})},t.prototype.show=function(){var t,e,a,s,i;return i=0,this.tm=new TimelineMax({paused:!0}),s=new SplitText(this.h4,{type:"words,chars"}),e=s.chars,a=new SplitText(this.h2,{type:"words,chars"}),t=a.chars,this.tm.to(this.h1,1,{autoAlpha:1,scrambleText:{text:"Horaires ",chars:"Nique la sncf",revealDelay:.5,tweenLength:!1,ease:Linear.easeNone}},i+=1.5),this.tm.to(this.container,1.5,{autoAlpha:1,ease:Ease.easeIn},i+=.2),this.tm.to(this.img,1,{autoAlpha:1,x:0,scale:1,ease:Ease.easeIn},i+=.2),this.tm.staggerFrom(e,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% 50% -50",ease:Back.easeOut},.01,i+=.8),this.tm.staggerFrom(t,.8,{opacity:0,scale:0,y:80,rotationX:180,transformOrigin:"0% -50% 50",ease:Back.easeOut},.01,i+=.8),this.tm.to(this.h3,.5,{autoAlpha:1,x:0,ease:Back.easeOut},i+=.2),this.tm.to(this.h5,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.to(this.arrow,.8,{autoAlpha:1,y:0,ease:Back.easeOut},i+=.2),this.tm.play()},t.prototype.hide=function(){return this.tm.reverse()},t}(),module.exports=TravelAnimationPage;
//# sourceMappingURL=out.js.map

},{}]},{},[4])