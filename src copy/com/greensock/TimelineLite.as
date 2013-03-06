﻿/**
 * VERSION: 12.0 beta 5
 * DATE: 2012-03-27
 * AS3 (AS2 version is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com/timelinelite/
 **/
package com.greensock {
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.core.SimpleTimeline;
/**
 * TimelineLite is a powerful sequencing tool that acts as a container for tweens and 
 * other timelines, making it simple to control them as a whole and precisely manage their
 * timing. Without TimelineLite (or its big brother TimelineMax), building complex sequences
 * would be far more cumbersome because you'd need to use the <code>delay</code> special property
 * for everything which would make future edits far more tedius. Here is a basic example: 
 * <listing version="3.0">
TweenLite.to(mc, 1, {x:100});
TweenLite.to(mc, 1, {y:50, delay:1});
TweenLite.to(mc, 1, {alpha:0, delay:2});
</listing>
 * The above code animates <code>mc.x</code> to 100, then <code>mc.y</code> to 50, and finally 
 * <code>mc.alpha</code> to 0 (notice the <code>delay</code> in all but the first tween). But 
 * imagine if you wanted to increase the duration of the first tween to 1.5 - you'd need to
 * adjust every delay thereafter. And what if you want to <code>pause()</code> the whole 
 * sequence or <code>restart()</code> it or <code>reverse()</code> it on-the-fly or jump to
 * a specific point in the whole animation? This becomes quite messy (or flat-out impossible), 
 * but TimelineLite makes it incredibly simple:
 * 
 * <listing version="3.0">
var tl = new TimelineLite();
tl.append( TweenLite.to(mc, 1, {x:100}) );
tl.append( TweenLite.to(mc, 1, {y:50}) );
tl.append( TweenLite.to(mc, 1, {alpha:0}) );
 
//then later, control the whole thing...
tl.pause();
tl.resume();
tl.seek(1.5);
tl.reverse();
...
</listing>
 * Or use the convenient <code>to()</code> method and chaining to make it much more concise:
 * <listing version="3.0">
var tl = new TimelineLite();
tl.to(mc, 1, {x:100}).to(mc, 1, {y:50}).to(mc, 1, {alpha:0});
</listing>
 * 
 * <p>Now you can feel free to adjust any of the tweens without worrying about trickle-down
 * changes to delays. Increase the duration of that first tween and everything automatically
 * adjusts.</p>
 * 
 * <p>Here are some other benefits and features of TimelineLite:</p>
 * 
 * 	<ul>
 * 		<li> Things can overlap on the timeline as much as you want. You have complete control 
 * 			over where tweens/timelines are placed. Most other animation tools can only do basic 
 * 			one-after-the-other sequencing but can't allow things to overlap. Imagine appending
 * 			a tween that moves an object and you want it to start fading out 0.5 seconds before the 
 * 			end of that tween? With TimelineLite it's easy.</li>
 * 
 * 		<li> Add labels, play(), stop(), seek(), restart(), and even reverse() smoothly anytime.</li>
 * 		
 * 		<li> Nest timelines within timelines as deeply as you want. This means you can modularize
 * 			your code and make it far more efficient. Imagine building your app with common animateIn() 
 * 			and animateOut() methods that return a tween or timeline instance, then you can string 
 * 			things together like 
 * 			<code>myTimeline.append( myObject.animateIn() ).append( myObject.animateOut(), 4).append( myObject2.animateIn(), -0.5)...</code></li>
 * 		
 * 		<li> Speed up or slow down the entire timeline with its <code>timeScale()</code> method. 
 * 			You can even tween it to gradually speed up or slow down the animation smoothly.</li>
 * 		
 * 		<li> Get or set the progress of the timeline using its <code>progress()</code> method. 
 * 			For example, to skip to the halfway point, set <code>myTimeline.progress(0.5);</code></li>
 * 		  
 * 		<li> Tween the <code>time</code> or <code>progress</code> to fastforward/rewind 
 * 			the timeline. You could even attach a slider to one of these properties to give the 
 * 			user the ability to drag forward/backward through the timeline.</li>
 * 		  
 * 		<li> Add <code>onComplete, onStart, onUpdate,</code> and/or <code>onReverseComplete</code> 
 * 			callbacks using the constructor's <code>vars</code> object like
 * 			<code>var tl = new TimelineLite({onComplete:myFunction});</code></li>
 * 
 * 		<li> Kill the tweens of a particular object inside the timeline with <code>killTweensOf()</code> 
 * 			or get the tweens of an object with <code>getTweensOf()</code> or get all the tweens/timelines 
 * 			in the timeline with <code>getChildren()</code></li>
 * 		  
 * 		<li> By passing <code>useFrames:true</code> in the <code>vars</code> parameter, you can
 * 			base the timing on frames instead of seconds. Please note, however, that
 * 		  the timeline's timing mode dictates its childrens' timing mode as well. </li>
 * 		
 * 		<li> You can export all the tween/timelines from the root (master) timeline anytime into 
 * 			a TimelineLite instance using <code>TimelineLite.exportRoot()</code> so that
 * 			you can <code>pause()</code> them all or <code>reverse()</code> or alter their 
 * 			<code>timeScale</code>, etc. without affecting tweens/timelines that you create in
 * 			the future. Imagine a game that has all its animation driven by the GreenSock 
 * 			Animation Platform and it needs to pause or slow down while a status screen pops up. 
 * 			Very easy.</li>
 * 		  
 * 		<li> If you need even more features like <code>repeat, repeatDelay, yoyo, currentLabel(), 
 * 			getLabelAfter(), getLabelBefore(), addCallback(), removeCallback(), getActive()</code>, 
 * 			AS3 event listeners and more, check out TimelineMax which extends TimelineLite.</li>
 * 	</ul>
 * 
 * 
 * <p><strong>SPECIAL PROPERTIES:</strong></p>
 * <p>You can optionally use the constructor's <code>vars</code> parameter to define any of
 * the special properties below (syntax example: <code>new TimelineLite({onComplete:myFunction, delay:2});</code></p>
 * 
 * <ul>
 * 	<li><strong> delay </strong>:<em> Number</em> -
 * 				 Amount of delay in seconds (or frames for frames-based tweens) before the timeline should begin.</li>
 * 
 *  <li><strong> paused </strong>:<em> Boolean</em> -
 * 				 If <code>true</code>, the timeline will pause itself immediately upon creation (by default, 
 * 				 timelines automatically begin playing immediately). If you plan to create a TimelineLite and 
 * 				 then populate it later (after one or more frames elapse), it is typically best to set 
 * 				 <code>paused:true</code> and then <code>play()</code> after you populate it.</li>
 * 	
 * 	<li><strong> onComplete </strong>:<em> Function</em> -
 * 				 A function that should be called when the timeline has completed</li>
 * 	
 * 	<li><strong> onCompleteParams </strong>:<em> Array</em> -
 * 				 An Array of parameters to pass the <code>onComplete</code> function. For example,
 * 				 <code>new TimelineLite({onComplete:myFunction, onCompleteParams:["param1", "param2"]});</code>
 * 				 To self-reference the timeline instance itself in one of the parameters, use <code>"{self}"</code>,
 * 				 like: <code>onCompleteParams:["{self}", "param2"]</code></li>
 * 	
 * 	<li><strong> useFrames </strong>:<em> Boolean</em> -
 * 				 If <code>useFrames</code> is <code>true</code>, the timelines's timing will be 
 * 				 based on frames instead of seconds because it is intially added to the root
 * 				 frames-based timeline. This causes both its <code>duration</code>
 * 				 and <code>delay</code> to be based on frames. An animations's timing mode is 
 * 				 always determined by its parent <code>timeline</code>.</li>
 * 
 *  <li><strong> tweens </strong>:<em> Array</em> -
 * 				 To immediately insert several tweens into the timeline, use the <code>tweens</code> 
 * 				 special property to pass in an Array of TweenLite/TweenMax/TimelineLite/TimelineMax 
 * 				 instances. You can use this in conjunction with the <code>align</code> and 
 * 				 <code>stagger</code> special properties to set up complex sequences with minimal code.
 * 				 These values simply get passed to the <code>insertMultiple()</code> method.</li>
 * 	
 * 	<li><strong> align </strong>:<em> String</em> -
 * 				 Only used in conjunction with the <code>tweens</code> special property when multiple 
 * 				 tweens are	to be inserted immediately. The value simply gets passed to the 
 * 				 <code>insertMultiple()</code> method. The default is <code>"normal"</code>. 
 * 				 Options are:
 * 					<ul>
 * 						<li><strong><code>"sequence"</code></strong>: aligns the tweens one-after-the-other in a sequence</li>
 * 						<li><strong><code>"start"</code></strong>: aligns the start times of all of the tweens (ignores delays)</li>
 * 						<li><strong><code>"normal"</code></strong>: aligns the start times of all the tweens (honors delays)</li>
 * 					</ul>
 * 				The <code>align</code> special property does <strong>not</strong> force all child 
 * 				tweens/timelines to maintain relative positioning, so for example, if you use 
 * 				<code>"sequence"</code> and then later change the duration of one of the nested tweens, 
 * 				it does <strong>not</strong> force all subsequent timelines to change their position.
 * 				The <code>align</code> special property only affects the alignment of the tweens that are
 * 				initially placed into the timeline through the <code>tweens</code> special property of 
 * 				the <code>vars</code> object.</li>
 * 										
 * 	<li><strong> stagger </strong>:<em> Number</em> -
 * 				 Only used in conjunction with the <code>tweens</code> special property when multiple 
 * 				 tweens are	to be inserted immediately. It staggers the tweens by a set amount of time 
 * 				 in seconds (or in frames if <code>useFrames</code> is true). For example, if the 
 * 				 stagger value is 0.5 and the "align" property is set to <code>"start"</code>, the 
 * 				 second tween will start 0.5 seconds after the first one starts, then 0.5 seconds 
 * 				 later the third one will start, etc. If the align property is <code>"sequence"</code>,
 * 				 there would be 0.5 seconds added between each tween. This value simply gets 
 * 				 passed to the <code>insertMultiple()</code> method. Default is 0.</li>
 * 
 *  <li><strong> onStart </strong>:<em> Function</em> -
 * 				 A function that should be called when the timeline begins (when its <code>time</code>
 * 				 changes from 0 to some other value which can happen more than once if the 
 * 				 timeline is restarted multiple times).</li>
 * 	
 * 	<li><strong> onStartParams </strong>:<em> Array</em> -
 * 				 An Array of parameters to pass the <code>onStart</code> function. For example, 
 * 				 <code>new TimelineLite({onStart:myFunction, onStartParams:["param1", "param2"]});</code>
 * 				 To self-reference the timeline instance itself in one of the parameters, use <code>"{self}"</code>,
 * 				 like: <code>onStartParams:["{self}", "param2"]</code></li>
 * 	
 * 	<li><strong> onUpdate </strong>:<em> Function</em> -
 * 				 A function that should be called every time the timeline updates  
 * 				 (on every frame while the timeline is active)</li>
 * 	
 * 	<li><strong> onUpdateParams </strong>:<em> Array</em> -
 * 				 An Array of parameters to pass the <code>onUpdate</code> function. For example,
 * 				 <code>new TimelineLite({onUpdate:myFunction, onUpdateParams:["param1", "param2"]});</code>
 * 				 To self-reference the timeline instance itself in one of the parameters, use <code>"{self}"</code>,
 * 				 like: <code>onUpdateParams:["{self}", "param2"]</code></li>
 * 	
 * 	<li><strong> onReverseComplete </strong>:<em> Function</em> -
 * 				 A function that should be called when the timeline has reached its beginning again from the 
 * 				 reverse direction. For example, if <code>reverse()</code> is called, the timeline will move
 * 				 back towards its beginning and when its <code>time</code> reaches 0, <code>onReverseComplete</code>
 * 				 will be called. This can also happen if the timeline is placed in a TimelineLite or TimelineMax 
 * 				 instance that gets reversed and plays the timeline backwards to (or past) the beginning.</li>
 * 	
 * 	<li><strong> onReverseCompleteParams </strong>:<em> Array</em> -
 * 				 An Array of parameters to pass the <code>onReverseComplete</code> function. For example, 
 * 				 <code>new TimelineLite({onReverseComplete:myFunction, onReverseCompleteParams:["param1", "param2"]});</code>
 * 				 To self-reference the timeline instance itself in one of the parameters, use <code>"{self}"</code>,
 * 				 like: <code>onReverseCompleteParams:["{self}", "param2"]</code></li>
 * 
 * <li><strong> autoRemoveChildren </strong>:<em> Boolean</em> -
 * 				If <code>autoRemoveChildren</code> is set to <code>true</code>, as soon as child 
 * 				tweens/timelines complete, they will automatically get killed/removed. This is normally 
 * 				undesireable because it prevents going backwards in time (like if you want to 
 * 				<code>reverse()</code> or set the <code>progress</code> lower, etc.). It can, however, 
 * 				improve speed and memory management. The root timelines use <code>autoRemoveChildren:true</code>.</li>
 * 
 * <li><strong> smoothChildTiming </strong>:<em> Boolean</em> -
 * 				Controls whether or not child tweens/timelines are repositioned automatically 
 * 				(changing their <code>startTime</code>) in order to maintain smooth playback when 
 * 				properties are changed on-the-fly. For example, imagine that the timeline's playhead is 
 * 				on a child tween that is 75% complete, moving mc.x from 0 to 100 and then that tween's 
 * 				<code>reverse()</code> method is called. If <code>smoothChildTiming</code> is <code>false</code> 
 * 				(the default except for the root timelines), the tween would flip in place, keeping its 
 * 				<code>startTime</code> consistent. Therefore the playhead of the timeline would now be 
 * 				at the tween's 25% completion point instead of 75%. Remember, the timeline's playhead 
 * 				position and direction are unaffected by child tween/timeline changes. mc.x would jump 
 * 				from 75 to 25, but the tween's position in the timeline would remain consistent. However, 
 * 				if <code>smoothChildTiming</code> is <code>true</code>, that child tween's 
 * 				<code>startTime</code> would be adjusted so that the timeline's playhead intersects 
 * 				with the same spot on the tween (75% complete) as it had immediately before 
 * 				<code>reverse()</code> was called, thus playback appears perfectly smooth. mc.x 
 * 				would still be 75 and it would continue from there as the playhead moves on, but 
 * 				since the tween is reversed now mc.x will travel back towards 0 instead of 100. 
 * 				Ultimately it's a decision between prioritizing smooth on-the-fly playback 
 * 				(<code>true</code>) or consistent position(s) of child tweens/timelines 
 * 				(<code>false</code>). 
 * 
 * 				Some examples of on-the-fly changes to child tweens/timelines that could cause their 
 * 				<code>startTime</code> to change when <code>smoothChildTiming</code> is <code>true</code> 
 * 				are: <code>reversed, timeScale, progress, totalProgress, time, totalTime, delay, pause, 
 * 				resume, duration,</code> and <code>totalDuration</code>.</li>
 * 	
 * 	</ul>
 * 
 * @example Sample code:<listing version="3.0">
//create the timeline with an onComplete callback that calls myFunction() when the timeline completes
var tl = new TimelineLite({onComplete:myFunction});

//add a tween
tl.append( new TweenLite(mc, 1, {x:200, y:100}) );
		
//add another tween at the end of the timeline (makes sequencing easy)
tl.append( new TweenLite(mc, 0.5, {alpha:0}) );
 
//append a tween using the convenience method (shorter syntax) and offset it by 0.5 seconds
tl.to(mc, 1, {rotation:30}, 0.5);
 		
//reverse anytime
tl.reverse();

//Add a "spin" label 3-seconds into the timeline
tl.addLabel("spin", 3);

//insert a rotation tween at the "spin" label (you could also define the insertion point as the time instead of a label)
tl.insert( new TweenLite(mc, 2, {rotation:"360"}), "spin");
	
//go to the "spin" label and play the timeline from there
tl.play("spin");

//nest another TimelineLite inside your timeline...
var nested = new TimelineLite();
nested.to(mc2, 1, {x:200}));
tl.append(nested);
</listing>
 * 
 * <p><strong>Copyright 2008-2012, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 * 	
 **/
	public class TimelineLite extends SimpleTimeline {
		/** @private **/
		public static const version:Number = 12.0;
		/** @private **/
		protected static const _paramProps:Array = ["onStartParams","onUpdateParams","onCompleteParams","onReverseCompleteParams","onRepeatParams"];
		
		/** @private **/
		protected var _labels:Object;
		
		/**
		 * Constructor.
		 * 
		 * <p><strong>SPECIAL PROPERTIES</strong></p>
		 * <p>The following special properties may be passed in via the constructor's vars parameter, like
		 * <code>new TimelineLite({paused:true, onComplete:myFunction})</code></p>
		 * 
		 * <ul>
		 * 	<li><strong> delay </strong>:<em> Number</em> -
		 * 				 Amount of delay in seconds (or frames for frames-based tweens) before the timeline should begin.</li>
		 * 
		 *  <li><strong> paused </strong>:<em> Boolean</em> -
		 * 				 If <code>true</code>, the timeline will pause itself immediately upon creation (by default, 
		 * 				 timelines automatically begin playing immediately). If you plan to create a TimelineLite and 
		 * 				 then populate it later (after one or more frames elapse), it is typically best to set 
		 * 				 <code>paused:true</code> and then <code>play()</code> after you populate it.</li>
		 * 	
		 * 	<li><strong> onComplete </strong>:<em> Function</em> -
		 * 				 A function that should be called when the timeline has completed</li>
		 * 	
		 * 	<li><strong> onCompleteParams </strong>:<em> Array</em> -
		 * 				 An Array of parameters to pass the <code>onComplete</code> function. For example,
		 * 				 <code>new TimelineLite({onComplete:myFunction, onCompleteParams:["param1", "param2"]});</code></li>
		 * 	
		 * 	<li><strong> useFrames </strong>:<em> Boolean</em> -
		 * 				 If <code>useFrames</code> is <code>true</code>, the timelines's timing will be 
		 * 				 based on frames instead of seconds because it is intially added to the root
		 * 				 frames-based timeline. This causes both its <code>duration</code>
		 * 				 and <code>delay</code> to be based on frames. An animations's timing mode is 
		 * 				 always determined by its parent <code>timeline</code>.</li>
		 * 
		 *  <li><strong> tweens </strong>:<em> Array</em> -
		 * 				 To immediately insert several tweens into the timeline, use the <code>tweens</code> 
		 * 				 special property to pass in an Array of TweenLite/TweenMax/TimelineLite/TimelineMax 
		 * 				 instances. You can use this in conjunction with the <code>align</code> and 
		 * 				 <code>stagger</code> special properties to set up complex sequences with minimal code.
		 * 				 These values simply get passed to the <code>insertMultiple()</code> method.</li>
		 * 	
		 * 	<li><strong> align </strong>:<em> String</em> -
		 * 				 Only used in conjunction with the <code>tweens</code> special property when multiple 
		 * 				 tweens are	to be inserted immediately. The value simply gets passed to the 
		 * 				 <code>insertMultiple()</code> method. The default is <code>"normal"</code>. 
		 * 				 Options are:
		 * 					<ul>
		 * 						<li><strong><code>"sequence"</code></strong>: aligns the tweens one-after-the-other in a sequence</li>
		 * 						<li><strong><code>"start"</code></strong>: aligns the start times of all of the tweens (ignores delays)</li>
		 * 						<li><strong><code>"normal"</code></strong>: aligns the start times of all the tweens (honors delays)</li>
		 * 					</ul>
		 * 				The <code>align</code> special property does <strong>not</strong> force all child 
		 * 				tweens/timelines to maintain relative positioning, so for example, if you use 
		 * 				<code>"sequence"</code> and then later change the duration of one of the nested tweens, 
		 * 				it does <strong>not</strong> force all subsequent timelines to change their position.
		 * 				The <code>align</code> special property only affects the alignment of the tweens that are
		 * 				initially placed into the timeline through the <code>tweens</code> special property of 
		 * 				the <code>vars</code> object.</li>
		 * 										
		 * 	<li><strong> stagger </strong>:<em> Number</em> -
		 * 				 Only used in conjunction with the <code>tweens</code> special property when multiple 
		 * 				 tweens are	to be inserted immediately. It staggers the tweens by a set amount of time 
		 * 				 in seconds (or in frames if <code>useFrames</code> is true). For example, if the 
		 * 				 stagger value is 0.5 and the "align" property is set to <code>"start"</code>, the 
		 * 				 second tween will start 0.5 seconds after the first one starts, then 0.5 seconds 
		 * 				 later the third one will start, etc. If the align property is <code>"sequence"</code>,
		 * 				 there would be 0.5 seconds added between each tween. This value simply gets 
		 * 				 passed to the <code>insertMultiple()</code> method. Default is 0.</li>
		 * 
		 *  <li><strong> onStart </strong>:<em> Function</em> -
		 * 				 A function that should be called when the timeline begins (when its <code>time</code>
		 * 				 changes from 0 to some other value which can happen more than once if the 
		 * 				 timeline is restarted multiple times).</li>
		 * 	
		 * 	<li><strong> onStartParams </strong>:<em> Array</em> -
		 * 				 An Array of parameters to pass the <code>onStart</code> function. For example, 
		 * 				 <code>new TimelineLite({onStart:myFunction, onStartParams:["param1", "param2"]});</code></li>
		 * 	
		 * 	<li><strong> onUpdate </strong>:<em> Function</em> -
		 * 				 A function that should be called every time the timeline updates  
		 * 				 (on every frame while the timeline is active)</li>
		 * 	
		 * 	<li><strong> onUpdateParams </strong>:<em> Array</em> -
		 * 				 An Array of parameters to pass the <code>onUpdate</code> function. For example,
		 * 				 <code>new TimelineLite({onUpdate:myFunction, onUpdateParams:["param1", "param2"]});</code></li>
		 * 	
		 * 	<li><strong> onReverseComplete </strong>:<em> Function</em> -
		 * 				 A function that should be called when the timeline has reached its beginning again from the 
		 * 				 reverse direction. For example, if <code>reverse()</code> is called, the timeline will move
		 * 				 back towards its beginning and when its <code>time</code> reaches 0, <code>onReverseComplete</code>
		 * 				 will be called. This can also happen if the timeline is placed in a TimelineLite or TimelineMax 
		 * 				 instance that gets reversed and plays the timeline backwards to (or past) the beginning.</li>
		 * 	
		 * 	<li><strong> onReverseCompleteParams </strong>:<em> Array</em> -
		 * 				 An Array of parameters to pass the <code>onReverseComplete</code> function. For example, 
		 * 				 <code>new TimelineLite({onReverseComplete:myFunction, onReverseCompleteParams:["param1", "param2"]});</code></li>
		 * 
		 * <li><strong> autoRemoveChildren </strong>:<em> Boolean</em> -
		 * 				If <code>autoRemoveChildren</code> is set to <code>true</code>, as soon as child 
		 * 				tweens/timelines complete, they will automatically get killed/removed. This is normally 
		 * 				undesireable because it prevents going backwards in time (like if you want to 
		 * 				<code>reverse()</code> or set the <code>progress</code> lower, etc.). It can, however, 
		 * 				improve speed and memory management. The root timelines use <code>autoRemoveChildren:true</code>.</li>
		 * 
		 * <li><strong> smoothChildTiming </strong>:<em> Boolean</em> -
		 * 				Controls whether or not child tweens/timelines are repositioned automatically 
		 * 				(changing their <code>startTime</code>) in order to maintain smooth playback when 
		 * 				properties are changed on-the-fly. For example, imagine that the timeline's playhead is 
		 * 				on a child tween that is 75% complete, moving mc.x from 0 to 100 and then that tween's 
		 * 				<code>reverse()</code> method is called. If <code>smoothChildTiming</code> is <code>false</code> 
		 * 				(the default except for the root timelines), the tween would flip in place, keeping its 
		 * 				<code>startTime</code> consistent. Therefore the playhead of the timeline would now be 
		 * 				at the tween's 25% completion point instead of 75%. Remember, the timeline's playhead 
		 * 				position and direction are unaffected by child tween/timeline changes. mc.x would jump 
		 * 				from 75 to 25, but the tween's position in the timeline would remain consistent. However, 
		 * 				if <code>smoothChildTiming</code> is <code>true</code>, that child tween's 
		 * 				<code>startTime</code> would be adjusted so that the timeline's playhead intersects 
		 * 				with the same spot on the tween (75% complete) as it had immediately before 
		 * 				<code>reverse()</code> was called, thus playback appears perfectly smooth. mc.x 
		 * 				would still be 75 and it would continue from there as the playhead moves on, but 
		 * 				since the tween is reversed now mc.x will travel back towards 0 instead of 100. 
		 * 				Ultimately it's a decision between prioritizing smooth on-the-fly playback 
		 * 				(<code>true</code>) or consistent position(s) of child tweens/timelines 
		 * 				(<code>false</code>). 
		 * 
		 * 				Some examples of on-the-fly changes to child tweens/timelines that could cause their 
		 * 				<code>startTime</code> to change when <code>smoothChildTiming</code> is <code>true</code> 
		 * 				are: <code>reversed, timeScale, progress, totalProgress, time, totalTime, delay, pause, 
		 * 				resume, duration,</code> and <code>totalDuration</code>.</li>
		 * 	
		 * 	</ul>
		 * 
		 * @param vars optionally pass in special properties like <code>onComplete, onCompleteParams, onUpdate, onUpdateParams, onStart, onStartParams, tweens, align, stagger, delay, useFrames,</code> and/or <code>autoRemoveChildren</code>.
		 */
		public function TimelineLite(vars:Object=null) {
			super(vars);
			_labels = {};
			autoRemoveChildren = (this.vars.autoRemoveChildren == true);
			smoothChildTiming = (this.vars.smoothChildTiming == true);
			_sortChildren = true;
			_onUpdate = this.vars.onUpdate;
			var i:int = _paramProps.length,
				j:int, a:Array;
			while (--i > -1) {
				if ((a = this.vars[_paramProps[i]])) {
					j = a.length;
					while (--j > -1) {
						if (a[j] === "{self}") {
							a = this.vars[_paramProps[i]] = a.concat(); //copy the array in case the user referenced the same array in multiple timelines/tweens (each {self} should be unique)
							a[j] = this;
						}
					}
				}
			}
			
			if (this.vars.tweens is Array) {
				this.insertMultiple(this.vars.tweens, 0, this.vars.align || "normal", this.vars.stagger || 0);
			}
		}
		
		
//---- START CONVENIENCE METHODS --------------------------------------
		
		/**
		 * Appends a <code>TweenLite.to()</code> tween to the end of the timeline (or elsewhere)
		 *  - this is a convenience method that accomplishes exactly the same thing as 
		 * <code>append( TweenLite.to(...) )</code> but with less code. In other 
		 * words, the following two lines produce identical results:
		 * 
		 * <listing version="3.0">
myTimeline.append( TweenLite.to(mc, 1, {x:100, alpha:0.5}) );
myTimeline.to(mc, 1, {x:100, alpha:0.5});
</listing>
		 * <p>Keep in mind that you can chain these calls together and use other convenience 
		 * methods like <code>fromTo(), call(), set(), staggerTo()</code>, etc. to build out 
		 * sequences very quickly:</p>
		 * 
		 * <listing version="3.0">
//create a timeline that calls myFunction() when it completes
var tl:TimelineLite = new TimelineLite({onComplete:myFunction});

//now we'll use chaining, but break each step onto a different line for readability...
tl.to(mc, 1, {x:100})		//tween mc.x to 100
  .to(mc, 1, {y:50}, -0.25)	//then tween mc.y to 50, starting the tween 0.25 seconds before the previous one ends
  .set(mc, {alpha:0})		//then set mc.alpha to 0.5 immediately
  .call(otherFunction)		//then call otherFunction()
  .staggerTo([mc1, mc2, mc3], 1.5, {rotation:45}, 0.25); //finally tween the rotation of mc1, mc2, and mc3 to 45 and stagger the start times by 0.25 seconds
</listing>
		 * <p>If you don't want to append the tween and would rather have precise control
		 * of the insertion point, you can use the additional <code>offset</code> and/or 
		 * <code>baseTimeOrLabel</code> parameters. Or use a regular <code>insert()</code> like 
		 * <code>myTimeline.insert( TweenLite.to(mc, 1, {x:100}), 2.75)</code>.</p>
		 * 
		 * <p>The 4th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the new
		 * tween gets inserted (although the 5th parameter allows you to define a different
		 * reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the tween starts. An offset of -0.5 would mean 
		 * the new tween gets inserted 0.5 seconds before the end of the timeline, so it will overlap 
		 * the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (5th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.to(mc, 1, {x:100}, 0, 0)</code> 
		 * would insert the tween at the very beginning of the timeline and 
		 * <code>myTimeline.to(mc, 1, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds 
		 * after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline 
		 * for easy sequencing which is the same as using the timeline's <code>duration()</code> 
		 * (i.e. omitting the 5th parameter, <code>myTimeline.to(mc, 1, {x:100}, 3)</code> is identical
		 * to defining it as the duration, like <code>myTimeline.to(mc, 1, {x:100}, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <listing version="3.0">
tl.to(mc, 1, {x:100});  //appends to the end of the timeline
tl.to(mc, 1, {x:100}, 2);  //appends it with a gap of 2 seconds
tl.to(mc, 1, {x:100}, 0, 0);  //places it at the very beginning of the timeline
tl.to(mc, 1, {x:100}, 2, "myLabel");  //places it 2 seconds after "myLabel"
</listing>
		 * 
		 * @param target Target object (or array of objects) whose properties the tween affects 
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param vars An object defining the end value for each property that should be tweened as well as any special properties like <code>onComplete</code>, <code>ease</code>, etc. For example, to tween <code>mc.x</code> to 100 and <code>mc.y</code> to 200 and then call <code>myFunction</code>, do this: <code>myTimeline.to(mc, 1, {x:100, y:200, onComplete:myFunction})</code>.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the tween from the end of the timeline. For example, to append a tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tween is inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.to(mc, 1, {x:100}, 0, 0)</code> would insert the tween at the very beginning of the timeline and <code>myTimeline.to(mc, 1, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.to(mc, 1, {x:100}, 0, myTimeline.duration())</code>).
		 * @return self (makes chaining easier)
		 * @see #from()
		 * @see #fromTo()
		 * @see #append()
		 * @see #insert()
		 * @see #remove()
		 */
		public function to(target:Object, duration:Number, vars:Object, offset:Number=0, baseTimeOrLabel:*=null):* {
			return insert( new TweenLite(target, duration, vars), _parseTimeOrLabel(baseTimeOrLabel) + offset); 
		}
		
		/**
		 * Appends a <code>TweenLite.from()</code> tween to the end of the timeline (or elsewhere)
		 * - this is a convenience method that accomplishes exactly the same thing as 
		 * <code>append( TweenLite.from(...) )</code> but with less code. In other 
		 * words, the following two lines produce identical results:
		 * 
		 * <listing version="3.0">
myTimeline.append( TweenLite.from(mc, 1, {x:100, alpha:0.5}) );
myTimeline.from(mc, 1, {x:100, alpha:0.5});
</listing>
		 * <p>Keep in mind that you can chain these calls together and use other convenience 
		 * methods like <code>to(), call(), set(), staggerTo()</code>, etc. to build out 
		 * sequences very quickly:</p>
		 * 
		 * <listing version="3.0">
//create a timeline that calls myFunction() when it completes
var tl:TimelineLite = new TimelineLite({onComplete:myFunction});

//now we'll use chaining, but break each step onto a different line for readability...
tl.from(mc, 1, {x:-100})	//tween mc.x from -100
  .to(mc, 1, {y:50})	//then tween mc.y to 50
  .set(mc, {alpha:0})	//then set mc.alpha to 0.5 immediately
  .call(otherFunction)	//then call otherFunction()
  .staggerTo([mc1, mc2, mc3], 1.5, {rotation:45}, 0.25); //finally tween the rotation of mc1, mc2, and mc3 to 45 and stagger the start times by 0.25 seconds
</listing>
		 * <p>If you don't want to append the tween and would rather have precise control
		 * of the insertion point, you can use the additional <code>offset</code> and/or 
		 * <code>baseTimeOrLabel</code> parameters. Or use a regular <code>insert()</code> like 
		 * <code>myTimeline.insert( TweenLite.from(mc, 1, {x:100}), 2.75)</code>.</p>
		 * 
		 * <p>The 4th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the new
		 * tween gets inserted (although the 5th parameter allows you to define a different
		 * reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the tween starts. An offset of -0.5 would mean 
		 * the new tween gets inserted 0.5 seconds before the end of the timeline, so it will overlap 
		 * the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (5th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.from(mc, 1, {x:100}, 0, 0)</code> 
		 * would insert the tween at the very beginning of the timeline and 
		 * <code>myTimeline.from(mc, 1, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds 
		 * after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline 
		 * for easy sequencing which is the same as using the timeline's <code>duration()</code> 
		 * (i.e. omitting the 5th parameter, <code>myTimeline.from(mc, 1, {x:100}, 3)</code> is identical
		 * to defining it as the duration, like <code>myTimeline.from(mc, 1, {x:100}, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <listing version="3.0">
tl.from(mc, 1, {x:100});  //appends to the end of the timeline
tl.from(mc, 1, {x:100}, 2);  //appends it with a gap of 2 seconds
tl.from(mc, 1, {x:100}, 0, 0);  //places it at the very beginning of the timeline
tl.from(mc, 1, {x:100}, 2, "myLabel");  //places it 2 seconds after "myLabel"
</listing>
		 * 
		 * <p><strong>NOTE:</strong> By default, <code>immediateRender</code> is <code>true</code> in 
		 * <code>from()</code> tweens, meaning that they immediately render their starting state 
		 * regardless of any delay that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> parameter so that it will 
		 * wait to render until the tween actually begins.</p>
		 * 
		 * @param target Target object (or array of objects) whose properties the tween affects 
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param vars An object defining the starting value for each property that should be tweened as well as any special properties like <code>onComplete</code>, <code>ease</code>, etc. For example, to tween <code>mc.x</code> from 100 and <code>mc.y</code> from 200 and then call <code>myFunction</code>, do this: <code>myTimeline.from(mc, 1, {x:100, y:200, onComplete:myFunction});</code>
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the tween from the end of the timeline. For example, to append a tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tween is inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.from(mc, 1, {x:100}, 0, 0)</code> would insert the tween at the very beginning of the timeline and <code>myTimeline.from(mc, 1, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.from(mc, 1, {x:100}, 0, myTimeline.duration())</code>).
		 * @return self (makes chaining easier)
		 * @see #to()
		 * @see #fromTo()
		 * @see #append()
		 * @see #insert()
		 * @see #remove()
		 */
		public function from(target:Object, duration:Number, vars:Object, offset:Number=0, baseTimeOrLabel:*=null):* {
			return insert( TweenLite.from(target, duration, vars), _parseTimeOrLabel(baseTimeOrLabel) + offset);
		}
		
		/**
		 * Appends a <code>TweenLite.fromTo()</code> tween to the end of the timeline - this is 
		 * a convenience method that accomplishes exactly the same thing as 
		 * <code>append( TweenLite.fromTo(...) )</code> but with less code. In other 
		 * words, the following two lines produce identical results:
		 * 
		 * <listing version="3.0">
myTimeline.append( TweenLite.fromTo(mc, 1, {x:0, alpha:1}, {x:100, alpha:0.5}) );
myTimeline.fromTo(mc, 1, {x:0, alpha:1}, {x:100, alpha:0.5});
</listing>
		 * <p>Keep in mind that you can chain these calls together and use other convenience 
		 * methods like <code>to(), call(), set(), staggerTo()</code>, etc. to build out 
		 * sequences very quickly:</p>
		 * 
		 * <listing version="3.0">
//create a timeline that calls myFunction() when it completes
var tl:TimelineLite = new TimelineLite({onComplete:myFunction});

//now we'll use chaining, but break each step onto a different line for readability...
tl.fromTo(mc, 1, {x:0}, {x:-100})	//tween mc.x from 0 to -100
  .to(mc, 1, {y:50}, -0.25)		//then tween mc.y to 50, starting it 0.25 seconds before the previous tween ends
  .set(mc, {alpha:0})			//then set mc.alpha to 0.5 immediately
  .call(otherFunction)			//then call otherFunction()
  .staggerTo([mc1, mc2, mc3], 1.5, {rotation:45}, 0.25); //finally tween the rotation of mc1, mc2, and mc3 to 45 and stagger the start times by 0.25 seconds
</listing>
		 * <p>If you don't want to append the tween and would rather have precise control
		 * of the insertion point, you can use the additional <code>offset</code> and/or 
		 * <code>baseTimeOrLabel</code> parameters. Or use a regular <code>insert()</code> like 
		 * <code>myTimeline.insert( TweenLite.fromTo(mc, 1, {x:0}, {x:100}), 2.75)</code>.</p>
		 * 
		 * <p>The 5th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the new
		 * tween gets inserted (although the 6th parameter allows you to define a different
		 * reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the tween starts. An offset of -0.5 would mean 
		 * the new tween gets inserted 0.5 seconds before the end of the timeline, so it will overlap 
		 * the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (6th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 0, 0)</code> 
		 * would insert the tween at the very beginning of the timeline and 
		 * <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds 
		 * after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline 
		 * for easy sequencing which is the same as using the timeline's <code>duration()</code> 
		 * (i.e. omitting the 6th parameter, <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 3)</code> is identical
		 * to defining it as the duration, like <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <listing version="3.0">
tl.fromTo(mc, 1, {x:0}, {x:100});  //appends to the end of the timeline
tl.fromTo(mc, 1, {x:0}, {x:100}, 2);  //appends it with a gap of 2 seconds
tl.fromTo(mc, 1, {x:0}, {x:100}, 0, 0);  //places it at the very beginning of the timeline
tl.fromTo(mc, 1, {x:0}, {x:100}, 2, "myLabel");  //places it 2 seconds after "myLabel"
</listing>
		 * 
		 * @param target Target object (or array of objects) whose properties the tween affects
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param fromVars An object defining the starting value for each property that should be tweened. For example, to tween <code>mc.x</code> from 100 and <code>mc.y</code> from 200, <code>fromVars</code> would look like this: <code>{x:100, y:200}</code>.
		 * @param toVars An object defining the end value for each property that should be tweened as well as any special properties like <code>onComplete</code>, <code>ease</code>, etc. For example, to tween <code>mc.x</code> from 0 to 100 and <code>mc.y</code> from 0 to 200 and then call <code>myFunction</code>, do this: <code>myTimeline.fromTo(mc, 1, {x:0, y:0}, {x:100, y:200, onComplete:myFunction});</code>
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the tween from the end of the timeline. For example, to append a tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tween is inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 0, 0)</code> would insert the tween at the very beginning of the timeline and <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 2, "myLabel")</code> would insert the tween 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.fromTo(mc, 1, {x:0}, {x:100}, 0, myTimeline.duration())</code>).
		 * @return self (makes chaining easier)
		 * @see #to()
		 * @see #from()
		 * @see #append()
		 * @see #insert()
		 * @see #remove()
		 */
		public function fromTo(target:Object, duration:Number, fromVars:Object, toVars:Object, offset:Number=0, baseTimeOrLabel:*=null):* {
			return insert( TweenLite.fromTo(target, duration, fromVars, toVars), _parseTimeOrLabel(baseTimeOrLabel) + offset);
		}
		
		/**
		 * Tweens an array of targets to a common set of destination values, but staggers their
		 * start times by a specified amount of time, creating an evenly-spaced sequence with a
		 * surprisingly small amount of code. For example, let's say you have an array containing
		 * references to a bunch of text fields that you'd like to fall away and fade out in a
		 * staggered fashion with 0.2 seconds between each tween's start time:
		 * 
		 * <listing version="3.0">
var textFields = [tf1, tf2, tf3, tf4, tf5];
myTimeline.staggerTo(textFields, 1, {y:"+150", ease:CubicIn.ease}, 0.2);
</listing>
		 * <p><code>staggerTo()</code> simply loops through the <code>targets</code> array and creates 
		 * a <code>to()</code> tween for each object and then inserts it at the appropriate place on a 
		 * new TimelineLite instance whose onComplete corresponds to the <code>onCompleteAll</code> 
		 * (if you define one) and then appends that TimelineLite to the timeline (as a nested child).</p>
		 * 
		 * <p>Note that if you define an <code>onComplete</code> (or any callback for that matter)
		 * in the <code>vars</code> parameter, it will be called for each tween rather than the whole 
		 * sequence. This can be very useful, but if you want to call a function after the entire
		 * sequence of tweens has completed, use the <code>onCompleteAll</code> parameter (the 7th parameter).</p>
		 * 
		 * <p>The 5th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the 
		 * first staggered tween gets inserted (although the 6th parameter allows you to define a 
		 * different reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the first staggered tween starts. An offset of 
		 * -0.5 would mean the first staggered tween gets inserted 0.5 seconds before the end of 
		 * the timeline, so it will overlap the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (6th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, 0)</code> 
		 * would insert the first tween at the very beginning of the timeline and 
		 * <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, "myLabel")</code> 
		 * would insert the first tween 3 seconds after the "myLabel" label. Again, the default 
		 * is the <strong>end</strong> of the timeline for easy sequencing which is the same as 
		 * using the timeline's <code>duration()</code> (i.e. omitting the 6th parameter, 
		 * <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3)</code> is identical
		 * to defining it as the duration, like 
		 * <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <p><strong>Javascript and AS2 note:</strong> - Due to the way Javascript and AS2 don't 
		 * maintain scope (what "<code>this</code>" refers to, or the context) in function calls, 
		 * it can be useful to define the scope specifically. Therefore, in the Javascript and AS2 
		 * versions accept an extra (9th) parameter for <code>onCompleteAllScope</code>.</p>
		 * 
		 * @param targets An array of target objects whose properties should be affected
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param vars An object defining the end value for each property that should be tweened as well as any special properties like <code>ease</code>. For example, to tween <code>x</code> to 100 and <code>y</code> to 200 for mc1, mc2, and mc3, staggering their start time by 0.25 seconds and then call <code>myFunction</code> when they last one has finished, do this: <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:100, y:200}, 0.25, 0, null, myFunction})</code>.
		 * @param stagger Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: <code>myTimeline.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+100", alpha:0}, 0.2)</code>.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the first tween from the end of the timeline. For example, to append the first tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tweens are inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, 0)</code> would insert the tweens beginning at the very start of the timeline and <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, "myLabel")</code> would insert the tweens beginning 3 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.staggerTo([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, myTimeline.duration())</code>).
		 * @param onCompleteAll A function to call as soon as the entire sequence of tweens has completed
		 * @param onCompleteAllParams An array of parameters to pass the <code>onCompleteAll</code> method.
		 * @return self (makes chaining easier) 
		 * @see #staggerFrom()
		 * @see #staggerFromTo()
		 */
		public function staggerTo(targets:Array, duration:Number, vars:Object, stagger:Number, offset:Number=0, baseTimeOrLabel:*=null, onCompleteAll:Function=null, onCompleteAllParams:Array=null):* {
			var tl:TimelineLite = new TimelineLite({onComplete:onCompleteAll, onCompleteParams:onCompleteAllParams});
			for (var i:int = 0; i < targets.length; i++) {
				tl.insert( new TweenLite(targets[i], duration, vars), i * stagger);
			}
			return insert(tl, _parseTimeOrLabel(baseTimeOrLabel) + offset);
		}
		
		/**
		 * Tweens an array of targets from a common set of destination values (using the current
		 * values as the destination), but staggers their start times by a specified amount of time, 
		 * creating an evenly-spaced sequence with a surprisingly small amount of code. For example, 
		 * let's say you have an array containing references to a bunch of text fields that you'd 
		 * like to drop into place while fading in, all in a staggered fashion with 0.2 seconds 
		 * between each tween's start time:
		 * 
		 * <listing version="3.0">
var textFields = [tf1, tf2, tf3, tf4, tf5];
myTimeline.staggerFrom(textFields, 1, {y:"+150"}, 0.2);
</listing>
		 * <p><code>staggerFrom()</code> simply loops through the <code>targets</code> array and creates 
		 * a <code>from()</code> tween for each object and then inserts it at the appropriate place on a 
		 * new TimelineLite instance whose onComplete corresponds to the <code>onCompleteAll</code> 
		 * (if you define one) and then appends that TimelineLite to the timeline (as a nested child).</p>
		 * 
		 * <p>Note that if you define an <code>onComplete</code> (or any callback for that matter)
		 * in the <code>vars</code> parameter, it will be called for each tween rather than the whole 
		 * sequence. This can be very useful, but if you want to call a function after the entire
		 * sequence of tweens has completed, use the <code>onCompleteAll</code> parameter (the 7th parameter).</p>
		 * 
		 * <p>The 5th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the 
		 * first staggered tween gets inserted (although the 6th parameter allows you to define a 
		 * different reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the first staggered tween starts. An offset of 
		 * -0.5 would mean the first staggered tween gets inserted 0.5 seconds before the end of 
		 * the timeline, so it will overlap the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (6th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, 0)</code> 
		 * would insert the first tween at the very beginning of the timeline and 
		 * <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, "myLabel")</code> 
		 * would insert the first tween 3 seconds after the "myLabel" label. Again, the default 
		 * is the <strong>end</strong> of the timeline for easy sequencing which is the same as 
		 * using the timeline's <code>duration()</code> (i.e. omitting the 6th parameter, 
		 * <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3)</code> is identical
		 * to defining it as the duration, like 
		 * <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <p>By default, <code>immediateRender</code> is <code>true</code> in 
		 * <code>from()</code> tweens, meaning that they immediately render their starting state 
		 * regardless of any delay that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> parameter so that it will 
		 * wait to render until the tween actually begins.</p>
		 * 
		 * <p><strong>Javascript and AS2 note:</strong> - Due to the way Javascript and AS2 don't 
		 * maintain scope (what "<code>this</code>" refers to, or the context) in function calls, 
		 * it can be useful to define the scope specifically. Therefore, in the Javascript and AS2 
		 * versions accept an extra (9th) parameter for <code>onCompleteAllScope</code>.</p>
		 * 
		 * @param targets An array of target objects whose properties should be affected
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param vars An object defining the beginning value for each property that should be tweened as well as any special properties like <code>ease</code>. For example, to tween <code>x</code> from 100 and <code>y</code> from 200 for mc1, mc2, and mc3, staggering their start time by 0.25 seconds and then call <code>myFunction</code> when they last one has finished, do this: <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:100, y:200}, 0.25, 0, null, myFunction})</code>.
		 * @param stagger Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: <code>myTimeline.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+100", alpha:0}, 0.2)</code>.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the first tween from the end of the timeline. For example, to append the first tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tweens are inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, 0)</code> would insert the tweens beginning at the very start of the timeline and <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 3, "myLabel")</code> would insert the tweens beginning 3 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.staggerFrom([mc1, mc2, mc3], 1, {x:"+=100"}, 0.2, 0, myTimeline.duration())</code>).
		 * @param onCompleteAll A function to call as soon as the entire sequence of tweens has completed
		 * @param onCompleteAllParams An array of parameters to pass the <code>onCompleteAll</code> method.
		 * @return self (makes chaining easier) 
		 * @see #staggerTo()
		 * @see #staggerFromTo()
		 */
		public function staggerFrom(targets:Array, duration:Number, vars:Object, stagger:Number=0, offset:Number=0, baseTimeOrLabel:*=null, onCompleteAll:Function=null, onCompleteAllParams:Array=null):* {
			vars = _prepVars(vars);
			if (!("immediateRender" in vars)) {
				vars.immediateRender = true;
			}
			vars.runBackwards = true;
			return staggerTo(targets, duration, vars, stagger, offset, baseTimeOrLabel, onCompleteAll, onCompleteAllParams);
		}
		
		/**
		 * Tweens an array of targets from and to a common set of values, but staggers their
		 * start times by a specified amount of time, creating an evenly-spaced sequence with a
		 * surprisingly small amount of code. For example, let's say you have an array containing
		 * references to a bunch of text fields that you'd like to fade from alpha:1 to alpha:0 in a
		 * staggered fashion with 0.2 seconds between each tween's start time:
		 * 
		 * <listing version="3.0">
var textFields = [tf1, tf2, tf3, tf4, tf5];
myTimeline.staggerFromTo(textFields, 1, {alpha:1}, {alpha:0}, 0.2);
</listing>
		 * <p><code>staggerFromTo()</code> simply loops through the <code>targets</code> array and creates 
		 * a <code>fromTo()</code> tween for each object and then inserts it at the appropriate place on 
		 * a new TimelineLite instance whose onComplete corresponds to the <code>onCompleteAll</code> 
		 * (if you define one) and then appends that TimelineLite to the timeline (as a nested child).</p>
		 * 
		 * <p>Note that if you define an <code>onComplete</code> (or any callback for that matter)
		 * in the <code>vars</code> parameter, it will be called for each tween rather than the whole 
		 * sequence. This can be very useful, but if you want to call a function after the entire
		 * sequence of tweens has completed, use the <code>onCompleteAll</code> parameter (the 8th parameter).</p>
		 * 
		 * <p>The 6th parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the 
		 * first staggered tween gets inserted (although the 7th parameter allows you to define a 
		 * different reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the first staggered tween starts. An offset of 
		 * -0.5 would mean the first staggered tween gets inserted 0.5 seconds before the end of 
		 * the timeline, so it will overlap the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (7th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 0, 0)</code> 
		 * would insert the first tween at the very beginning of the timeline and 
		 * <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 3, "myLabel")</code> 
		 * would insert the first tween 3 seconds after the "myLabel" label. Again, the default 
		 * is the <strong>end</strong> of the timeline for easy sequencing which is the same as 
		 * using the timeline's <code>duration()</code> (i.e. omitting the 7th parameter, 
		 * <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 3)</code> is identical
		 * to defining it as the duration, like 
		 * <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <p><strong>Javascript and AS2 note:</strong> - Due to the way Javascript and AS2 don't 
		 * maintain scope (what "<code>this</code>" refers to, or the context) in function calls, 
		 * it can be useful to define the scope specifically. Therefore, in the Javascript and AS2 
		 * versions accept an extra (10th) parameter for <code>onCompleteAllScope</code>.</p>
		 * 
		 * @param targets An array of target objects whose properties should be affected
		 * @param duration Duration in seconds (or frames if the timeline is frames-based)
		 * @param fromVars An object defining the starting value for each property that should be tweened. For example, to tween <code>x</code> from 100 and <code>y</code> from 200, <code>fromVars</code> would look like this: <code>{x:100, y:200}</code>.
		 * @param toVars An object defining the end value for each property that should be tweened as well as any special properties like <code>ease</code>. For example, to tween <code>x</code> from 0 to 100 and <code>y</code> from 0 to 200, staggering the start times by 0.2 seconds and then call <code>myFunction</code> when they all complete, do this: <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0, y:0}, {x:100, y:200}, 0.2, 0, null, myFunction});</code>
		 * @param stagger Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: <code>myTimeline.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+100", alpha:0}, 0.2)</code>.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the first tween from the end of the timeline. For example, to append the first tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the tweens are inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 0, 0)</code> would insert the tweens beginning at the very start of the timeline and <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 3, "myLabel")</code> would insert the tweens beginning 3 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.staggerFromTo([mc1, mc2, mc3], 1, {x:0}, {x:100}, 0.2, 0, myTimeline.duration())</code>).
		 * @param onCompleteAll A function to call as soon as the entire sequence of tweens has completed
		 * @param onCompleteAllParams An array of parameters to pass the <code>onCompleteAll</code> method.
		 * @return self (makes chaining easier) 
		 * @see #staggerTo()
		 * @see #staggerFrom()
		 */
		public function staggerFromTo(targets:Array, duration:Number, fromVars:Object, toVars:Object, stagger:Number=0, offset:Number=0, baseTimeOrLabel:*=null, onCompleteAll:Function=null, onCompleteAllParams:Array=null):* {
			toVars = _prepVars(toVars);
			fromVars = _prepVars(fromVars);
			toVars.startAt = fromVars;
			if (fromVars.immediateRender) {
				toVars.immediateRender = true;
			}
			return staggerTo(targets, duration, toVars, stagger, offset, baseTimeOrLabel, onCompleteAll, onCompleteAllParams);
		}
		
		/**
		 * Appends a callback to the end of the timeline - this is 
		 * a convenience method that accomplishes exactly the same thing as 
		 * <code>append( TweenLite.delayedCall(...) )</code> but with less code. In other 
		 * words, the following two lines produce identical results:
		 * 
		 * <listing version="3.0">
myTimeline.append( TweenLite.delayedCall(0, myFunction, ["param1", "param2"]) );
myTimeline.call(myFunction, ["param1", "param2"]);
</listing>
		 * <p>This is different than using the <code>onComplete</code> special property
		 * on the TimelineLite itself because once you append the callback, it stays in 
		 * place whereas an <code>onComplete</code> is always called at the very end of 
		 * the timeline. For example, if a timeline is populated with a 1-second tween and 
		 * then you <code>call(myFunction)</code>, it is placed at the 1-second spot. Then 
		 * if you append another 1-second tween, the timeline's duration will now be 2 seconds 
		 * but the myFunction callback will still be called at the 1-second spot. An 
		 * <code>onComplete</code> would be called at the end (2 seconds).</p>
		 * 
		 * <p>Keep in mind that you can chain these calls together and use other convenience 
		 * methods like <code>to(), fromTo(), set(), staggerTo()</code>, etc. to build out 
		 * sequences very quickly:</p>
		 * 
		 * <listing version="3.0">
//create a timeline that calls myFunction() when it completes
var tl:TimelineLite = new TimelineLite({onComplete:myFunction});

//now we'll use chaining, but break each step onto a different line for readability...
tl.to(mc, 1, {x:100})	//tween mc.x to 100
  .call(myCallback)		//then call myCallback()
  .set(mc, {alpha:0})	//then set mc.alpha to 0.5 immediately
  .call(otherFunction, ["param1", "param2"])	//then call otherFunction("param1", "param2")
  .staggerTo([mc1, mc2, mc3], 1.5, {rotation:45}, 0.25); //finally tween the rotation of mc1, mc2, and mc3 to 45 and stagger the start times by 0.25 seconds
</listing>
		 * 
		 * <p>The 3rd parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the
		 * callback gets inserted (although the 4th parameter allows you to define a different
		 * reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the callback. An offset of -0.5 would mean 
		 * the callback gets inserted 0.5 seconds before the end of the timeline, so it will 
		 * overlap the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (4th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.call(myFunction, null, 0, 0)</code> 
		 * would insert the callback at the very beginning of the timeline and 
		 * <code>myTimeline.call(myFunction, null, 2, "myLabel")</code> would insert the callback 
		 * 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of
		 * the timeline for easy sequencing which is the same as using the timeline's <code>duration()</code> 
		 * (i.e. omitting the 4th parameter, <code>myTimeline.call(myFunction, null, 3)</code> is identical
		 * to defining it as the duration, like <code>myTimeline.call(myFunction, null, 3, myTimeline.duration())</code>).</p>
		 * 
		 * <listing version="3.0">
tl.call(myFunction, [mc]);  //appends to the end of the timeline
tl.call(myFunction, [mc], 2);  //appends it with a gap of 2 seconds
tl.call(myFunction, [mc], 0, 0);  //places it at the very beginning of the timeline
tl.call(myFunction, [mc], 2, "myLabel");  //places it 2 seconds after "myLabel"
</listing>
		 * 
		 * <p><strong>Javascript and AS2 note:</strong> - Due to the way Javascript and AS2 don't 
		 * maintain scope (what "<code>this</code>" refers to, or the context) in function calls, 
		 * it can be useful to define the scope specifically. Therefore, in the Javascript and AS2 
		 * versions the 3rd parameter is <code>scope</code>, bumping <code>offset</code> 
		 * back to the 4th parameter, and <code>baseTimeOrLabel</code> to 5th.</p>
		 * 
		 * @param callback Function to call
		 * @param params An Array of parameters to pass the function.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the callback from the end of the timeline. For example, to append the callback 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the callback appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the callback is inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.call(myFunction, null, 0, 0)</code> would insert the callback at the very beginning of the timeline and <code>myTimeline.call(myFunction, null, 2, "myLabel")</code> would insert the callback 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.call(myFunction, null, 0, myTimeline.duration())</code>).
		 * @return self (makes chaining easier)
		 * @see #append()
		 * @see #insert()
		 * @see #remove()
		 */
		public function call(callback:Function, params:Array=null, offset:Number=0, baseTimeOrLabel:*=null):* {
			return insert( TweenLite.delayedCall(0, callback, params), _parseTimeOrLabel(baseTimeOrLabel) + offset);
		}
		
		/**
		 * Appends a zero-duration tween to the end of the timeline that
		 * sets values immediately (when the virtual playhead reaches that position
		 * on the timeline) - this is a convenience method that accomplishes exactly 
		 * the same thing as <code>append( TweenLite.to(target, 0, {...}) )</code> but 
		 * with less code. In other words, the following two lines produce identical results:
		 * 
		 * <listing version="3.0">
myTimeline.append( TweenLite.to(mc, 0, {x:100, alpha:0.5}) );
myTimeline.set(mc, {x:100, alpha:0.5});
</listing>
		 * <p>Keep in mind that you can chain these calls together and use other convenience 
		 * methods like <code>to(), call(), fromTo(), staggerTo()</code>, etc. to build out 
		 * sequences very quickly:</p>
		 * 
		 * <listing version="3.0">
//create a timeline that calls myFunction() when it completes
var tl:TimelineLite = new TimelineLite({onComplete:myFunction});

//now we'll use chaining, but break each step onto a different line for readability...
tl.to(mc, 1, {x:100})	//tween mc.x to 100
  .set(mc, {alpha:0})	//then set mc.alpha to 0.5 immediately
  .to(mc, 1, {y:50})	//then tween mc.y to 50
  .call(otherFunction)	//then call otherFunction()
  .staggerTo([mc1, mc2, mc3], 1.5, {rotation:45}, 0.25); //finally tween the rotation of mc1, mc2, and mc3 to 45 and stagger the start times by 0.25 seconds
</listing>
		 * <p>The 3rd parameter is the <code>offset</code> which can be positive or negative
		 * and it essentially controls the gap between the end of the timeline and where the
		 * zero-duration tween gets inserted (although the 4th parameter allows you to define a different
		 * reference point from which to offset, but since sequencing is so common, the default
		 * reference point is the end of the timeline). For example, an offset of 2 would cause 
		 * there to be a 2-second gap/delay before the tween. An offset of -0.5 would mean 
		 * the tween gets inserted 0.5 seconds before the end of the timeline, so it will 
		 * overlap the previous tween(s) by 0.5 seconds.</p>
		 * 
		 * <p>If you prefer to define a specific time or label to serve as the reference point
		 * from which to offset, use the <code>baseTimeOrLabel</code> (4th) parameter. For example, 
		 * 0 would be the beginning of the timeline. So <code>myTimeline.set(obj, {x:100, y:0}, 0, 0)</code> 
		 * would insert the tween at the very beginning of the timeline and 
		 * <code>myTimeline.set(obj, {x:100, y:0}, 2, "myLabel")</code> would insert the tween 
		 * 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of
		 * the timeline for easy sequencing which is the same as using the timeline's <code>duration()</code> 
		 * (i.e. omitting the 4th parameter, <code>myTimeline.set(obj, {x:100, y:0}, 3)</code> is identical
		 * to defining it as the duration, like <code>myTimeline.set(obj, {x:100, y:0}, 3, myTimeline.duration())</code>).</p>
		 * 
		 * @param target Target object (or array of objects) whose properties will be set. 
		 * @param vars An object defining the value to which each property should be set. For example, to set <code>mc.x</code> to 100 and <code>mc.y</code> to 200, do this: <code>myTimeline.set(mc, {x:100, y:200});</code>
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the zero-duration tween from the end of the timeline. For example, to append a tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @param baseTimeOrLabel By default, the zero-duration tween is inserted at the end of the timeline plus the <code>offset</code> (which is 0 by default), but you can define a specific time or label to serve as the reference point using <code>baseTimeOrLabel</code>. For example, 0 would be the beginning of the timeline. So <code>myTimeline.set(obj, {x:100, y:0}, 0, 0)</code> would insert the tween at the very beginning of the timeline and <code>myTimeline.set(obj, {x:100, y:0}, 2, "myLabel")</code> would insert the tween 2 seconds after the "myLabel" label. Again, the default is the <strong>end</strong> of the timeline (for easy sequencing) which is the same as using the timeline's <code>duration()</code> (i.e. <code>myTimeline.set(obj, {x:100, y:0}, 0, myTimeline.duration())</code>).
		 * @return self (makes chaining easier)
		 * @see #to()
		 * @see #append()
		 * @see #insert()
		 * @see #remove()
		 */
		public function set(target:Object, vars:Object, offset:Number=0, baseTimeOrLabel:*=null):* {
			vars.immediateRender = false;
			return insert( new TweenLite(target, 0, vars), _parseTimeOrLabel(baseTimeOrLabel) + offset);
		}
		
		/** @private **/
		protected static function _prepVars(vars:Object):Object { //to accommodate TweenLiteVars and TweenMaxVars instances for strong data typing and code hinting
			return (vars._isGSVars) ? vars.vars : vars;
		}
		
		
		/**
		 * Seamlessly transfers all tweens, timelines, and [optionally] delayed calls from the root 
		 * timeline into a new TimelineLite so that you can perform advanced tasks on a seemingly global 
		 * basis without affecting tweens/timelines that you create after the export. For example, imagine
		 * a game that uses the GreenSock Animation Platform for all of its animations and at some point
		 * during the game, you want to slow everything down to a stop (tweening the 
		 * <code>timeScale</code>) while at the same time animating a new popup window into place:
		 * 
		 * <listing version="3.0">
var tl = TimelineLite.exportRoot();
TweenLite.to(tl, 0.5, {timeScale:0});

//this tween isn't affected because it's created after the export.
TweenLite.fromTo(myWindow, 1, {scaleX:0, scaleY:0}, {scaleX:1, scaleY:1});
</listing>
		 * <p>You could then re-animate things when you're ready by tweening the <code>timeScale</code>
		 * back to 1. Or you could use <code>exportRoot()</code> to collect all the animations and 
		 * <code>pause()</code> them and then animate the popup screen (or whatever). Then <code>resume()</code>
		 * that instance or even <code>reverse()</code>.</p>
		 * 
		 * <p>You can <code>exportRoot()</code> as many times as you want; all it does is wrap all the 
		 * loose tweens/timelines/delayedCalls into a TimelineLite which itself gets placed onto the root, 
		 * so if you <code>exportRoot()</code> again, that TimelineLite would get wrapped into another one,
		 * etc. Things can be nested as deeply as you want.</p>
		 * 
		 * <p>Keep in mind, however, that completed tweens/timelines are removed from the root (for automatic 
		 * garbage collection), so if you <code>exportRoot()</code> after a tween completes, it won't be 
		 * included in the export. The only way around that is to set <code>autoRemoveChildren</code>
		 * property of the <code>Animation._rootTimeline</code> and <code>Animation._rootFramesTimeline</code>
		 * to <code>false</code>, but that is <strong>NOT</strong> recommended because you'd need to
		 * manually <code>kill()</code> your tweens/timelines manually to make them eligible for 
		 * garbage collection.</p>
		 * 
		 * @param vars The <code>vars</code> parameter that's passed to the TimelineLite's constructor which allows you to define things like onUpdate, onComplete, etc. The <code>useFrames</code> special property determines which root timeline gets exported. There are two distinct root timelines - one for frames-based animations (<code>useFrames:true</code>) and one for time-based ones. By default, the time-based timeline is exported. 
		 * @param omitDelayedCalls If <code>true</code> (the default), delayed calls will be left on the root rather than wrapped into the new TimelineLite. That way, if you <code>pause()</code> or alter the <code>timeScale</code>, or <code>reverse()</code>, they won't be affected. However, in some situations it might be very useful to have them included.
		 * @return A new TimelineLite instance containing the root tweens/timelines
		 */
		public static function exportRoot(vars:Object=null, omitDelayedCalls:Boolean=true):TimelineLite {
			vars = vars || {};
			if (!("smoothChildTiming" in vars)) {
				vars.smoothChildTiming = true;
			}
			var tl:TimelineLite = new TimelineLite(vars),
				root:SimpleTimeline = tl._timeline;
			root._remove(tl, true);
			tl._startTime = 0;
			tl._rawPrevTime = tl._time = tl._totalTime = root._time;
			var tween:Animation = root._first, next:Animation;
			while (tween) {
				next = tween._next;
				if (!omitDelayedCalls || !(tween is TweenLite && TweenLite(tween).target == tween.vars.onComplete)) {
					tl.insert(tween, tween._startTime - tween._delay);
				}
				tween = next;
			}
			root.insert(tl, 0);
			return tl;
		}
		
//---- END CONVENIENCE METHODS ----------------------------------------
		
		
		/**
		 * Inserts a tween, timeline, callback, or label into the timeline at a specific time, frame, 
		 * or label. This gives you complete control over the insertion point (<code>append()</code>
		 * always puts things at the end). 
		 * 
		 * <listing version="3.0">
 //insert a tween so that it starts at 1 second into the timeline
 myAnimation.insert(TweenLite.to(mc, 2, {x:100}), 1);
 
 //insert a callback at 1.5 seconds
 myAnimation.insert(myFunction, 1.5);
 
 //insert a label at 3 seconds
 myAnimation.insert("myLabel", 3);
 
 //create another timeline that we will insert
 var nested = new TimelineLite();
  
 //insert the timeline where the "myLabel" label is
 myAnimation.insert(nested, "myLabel");
		 </listing>
		 * 
		 * @param value The tween, timeline, callback, or label to insert
		 * @param timeOrLabel The time in seconds (or frames for frames-based timelines) or label at which to insert. For example, <code>myTimeline.insert(myTween, 3)</code> would insert myTween 3-seconds into the timeline, and <code>myTimeline.insert(myTween, "myLabel")</code> would insert it at the "myLabel" label. If you define a label that doesn't exist yet, one is appended to the end of the timeline.
		 * @return self (makes chaining easier)
		 * @see #append()
		 * @see #insertMultiple()
		 * @see #appendMultiple()
		 */
		override public function insert(value:*, timeOrLabel:*=0):* {
			if (value is Animation) {
				//continue...
			} else if (value is Array) {
				return insertMultiple(value, timeOrLabel);
			} else if (typeof(value) == "string") {
				return addLabel(String(value), _parseTimeOrLabel(timeOrLabel || 0, true));
			} else if (typeof(value) == "function") {
				value = TweenLite.delayedCall(0, value);
			} else {
				trace("ERROR: Cannot insert() " + value + " into the TimelineLite/Max because it is neither a tween, timeline, function, nor a String.");
				return this;
			}
			
			super.insert(value, _parseTimeOrLabel(timeOrLabel || 0, true));
			
			//if the timeline has already ended but the inserted tween/timeline extends the duration past the parent timeline's _time, we should enable this timeline again so that it renders properly.  
			if (_gc) if (!_paused) if (_startTime + (value._startTime + (value._totalDuration / value._timeScale)) / _timeScale > _timeline._time) {
				//in case any of the anscestors had completed but should now be enabled...
				var tl:SimpleTimeline = this;
				while (tl._gc && tl._timeline) {
					tl.totalTime(tl._totalTime, true); //also enables them
					tl = tl._timeline;
				}
			}
			
			return this;
		}
		
		/**
		 * Removes a tween, timeline, callback, or label from the timeline.
		 * 
		 * @param value The tween, timeline, callback, or label that should be removed from the timeline
		 * @return self (makes chaining easier)
		 */
		public function remove(value:*):* {
			if (value is Animation) {
				return _remove(value, false);
			} else if (value is Array) {
				var i:Number = value.length;
				while (--i > -1) {
					remove(value[i]);
				}
				return this;
			} else if (typeof(value) == "string") {
				return removeLabel(String(value));
			}
			return kill(null, value);
		}
		
		/**
		 * Appends a tween, timeline, callback, or label to the <strong>end</strong> of the timeline,
		 * optionally offsetting its insertion point by a certain amount (to make it overlap with the end of 
		 * the timeline or leave a gap before its insertion point). 
		 * This makes it easy to build sequences by continuing to append() tweens or timelines. You can
		 * chain append() calls together or use the convenience methods like <code>to(), from(), fromTo(),
		 * call(), set(), staggerTo(), staggerFrom(),</code> and <code>staggerFromTo()</code> to build
		 * sequences with minimal code. 
		 * 
		 * <p>To insert the tween/timeline/callback/label at a specific position on the timeline 
		 * rather than appending it to the end, use the <code>insert()</code> method.</p>
		 * 
		 * <listing version="3.0">
//append a tween
myTimeline.append(TweenLite.to(mc, 1, {x:100}));

//use the to() convenience method to add several sequenced tweens
myTimeline.to(mc, 1, {x:50}).to(mc, 1, {y:100}).to(mc2, 1, {alpha:0});
 
//append a callback
myTimeline.append(myFunction);

//append a label
myTimeline.append("myLabel");

//create another timeline and then append it
var nested = new TimelineLite();
myTimeline.append(nested);
</listing>
		 * 
		 * @param value The tween, timeline, callback, or label to append. You can even pass in an array of them.
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point from the end of the timeline. For example, to append 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have it appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @return self (makes chaining easier)
		 * @see #insert()
		 * @see #to()
		 * @see #from()
		 * @see #fromTo()
		 * @see #call()
		 * @see #set()
		 * @see #appendMultiple()
		 * @see #insertMultiple()
		 */
		public function append(value:*, offset:Number=0):* {
			return insert(value, duration() + offset);
		}
		
		/**
		 * Inserts multiple tweens/timelines/callbacks/labels into the timeline at once, optionally aligning them 
		 * (as a sequence for example) and/or staggering the timing. You can use the <code>insert()</code> method
		 * instead if you are not defining a <code>stagger</code> or <code>align</code> (either way works).
		 *  
		 * @param tweens An array containing the tweens, timelines, callbacks, or labels that should be inserted  
		 * @param timeOrLabel Time in seconds (or frame if the timeline is frames-based) or label that serves as the insertion point. For example, the number 2 would insert the first object in the array at 2-seconds into the timeline, or "myLabel" would ihsert them wherever "myLabel" is.
		 * @param align Determines how the tweens/timelines/callbacks/labels will be aligned in relation to each other before getting inserted. Options are: <code>"sequence"</code> (aligns them one-after-the-other in a sequence), <code>"start"</code> (aligns the start times of all of the objects (ignoring delays)), and <code>"normal"</code> (aligns the start times of all the tweens (honoring delays)). The default is <code>"normal"</code>.
		 * @param stagger Staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the <code>"align"</code> parameter is set to <code>"start"</code>, the second one will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is <code>"sequence"</code>, there would be 0.5 seconds added between each tween. Default is 0.
		 * @return self (makes chaining easier)
		 * @see #insert()
		 * @see #appendMultiple()
		 * @see #append()
		 * @see #staggerTo()
		 * @see #staggerFrom()
		 * @see #staggerFromTo()
		 */
		public function insertMultiple(tweens:Array, timeOrLabel:*=0, align:String="normal", stagger:Number=0):* {
			var i:int, tween:*, curTime:Number = _parseTimeOrLabel(timeOrLabel || 0, true), l:Number = tweens.length;
			for (i = 0; i < l; i++) {
				if ((tween = tweens[i]) is Array) {
					tween = new TimelineLite({tweens:tween});
				}
				insert(tween, curTime);
				if (typeof(tween) == "string" || typeof(tween) == "function") {
					//do nothing
				} else if (align == "sequence") {
					curTime = tween._startTime + (tween.totalDuration() / tween._timeScale);
				} else if (align == "start") {
					tween._startTime -= tween.delay();
				}
				curTime += stagger;
			}
			return _uncache(true);
		}
		
		/**
		 * Appends multiple tweens/timelines/callbacks/labels to the end of the timeline at once, optionally 
		 * offsetting the insertion point by a certain amount, aligning them (as a sequence for example), and/or 
		 * staggering their relative timing. You can use the <code>append()</code> method 
		 * instead if you are not defining a <code>stagger</code> or <code>align</code> (either way works).
		 * Check out the <code>staggerTo()</code> method for an even easier way to create and append
		 * a sequence of evenly-spaced tweens.
		 *  
		 * @param tweens An array containing the tweens, timelines, callbacks, and/or labels that should be appended  
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point from the end of the timeline. For example, to start appending 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have things appended so that the initial insertion point overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline. 
		 * @param align Determines how the objects will be aligned in relation to each other before getting appended. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is NORMAL.
		 * @param stagger Staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the <code>"align"</code> parameter is set to <code>"start"</code>, the second one will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is <code>"sequence"</code>, there would be 0.5 seconds added between each tween. Default is 0.
		 * @return The array of tweens that were appended
		 */
		public function appendMultiple(tweens:Array, offset:Number=0, align:String="normal", stagger:Number=0):* {
			return insertMultiple(tweens, duration() + offset, align, stagger);
		}
		
		/**
		 * Adds a label to the timeline, making it easy to mark important positions/times. You can then
		 * reference that label in other methods, like <code>seek("myLabel")</code> or <code>insert(myTween, "myLabel")</code>
		 * or <code>reverse("myLabel")</code>. You could also use the <code>append()</code> or
		 * <code>insert()</code> methods to insert/append a label.
		 * 
		 * @param label The name of the label
		 * @param time The time in seconds (or frames for frames-based timelines) at which the label should be inserted. For example, <code>myTimeline.addLabel("myLabel", 3)</code> adds the label "myLabel" at 3 seconds into the timeline.
		 */
		public function addLabel(label:String, time:Number):* {
			_labels[label] = time;
			return this;
		}
		
		/**
		 * 
		 * Removes a label from the timeline and returns the time of that label. You could 
		 * also use the <code>remove()</code> method to accomplish the same task.
		 * 
		 * @param label The name of the label to remove
		 * @return Time associated with the label that was removed
		 */
		public function removeLabel(label:String):* {
			delete _labels[label];
			return this;
		}
		
		/**
		 * Returns the time associated with a particular label. If the label isn't found, -1 is returned.
		 * 
		 * @param label Label name
		 * @return Time associated with the label (or -1 if there is no such label)
		 */
		public function getLabelTime(label:String):Number {
			return (label in _labels) ? Number(_labels[label]) : -1;
		}
		
		/** @private **/
		protected function _parseTimeOrLabel(timeOrLabel:*, appendIfAbsent:Boolean=false):Number {
			if (timeOrLabel == null) {
				return duration();
			} else if (typeof(timeOrLabel) == "string") {
				if (!(timeOrLabel in _labels)) {
					return (appendIfAbsent) ? (_labels[timeOrLabel] = duration()) : 0;
				}
				return _labels[timeOrLabel];
			}
			return Number(timeOrLabel);
		}
		
		/**
		 * Jumps to a specific time (or label) without affecting whether or not the instance 
		 * is paused or reversed.
		 * 
		 * <p>If there are any events/callbacks inbetween where the playhead was and the new time, 
		 * they will not be triggered because by default <code>suppressEvents</code> (the 2nd parameter) 
		 * is <code>true</code>. Think of it like picking the needle up on a record player and moving it 
		 * to a new position before placing it back on the record. If, however, you do not want the 
		 * events/callbacks suppressed during that initial move, simply set the <code>suppressEvents</code> 
		 * parameter to <code>false</code>.</p>
		 * 
		 * <listing version="3.0">
//jumps to exactly 2 seconds
myAnimation.seek(2);
 
//jumps to exactly 2 seconds but doesn't suppress events during the initial move:
myAnimation.seek(2, false);

//jumps to the "myLabel" label
myAnimation.seek("myLabel");
		 </listing>
		 * 
		 * @param time The time or label to go to.
		 * @param suppressEvents If <code>true</code> (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the <code>time</code> parameter.
		 * @return self (makes chaining easier)
		 * @see #time()
		 * @see #totalTime()
		 * @see #play()
		 * @see #reverse()
		 * @see #pause()
		 */
		override public function seek(timeOrLabel:*, suppressEvents:Boolean=true):* {
			return totalTime(_parseTimeOrLabel(timeOrLabel, false), suppressEvents);
		}
		
		/** [deprecated] Pauses the timeline (used for consistency with Flash's MovieClip.stop() functionality, but essentially accomplishes the same thing as <code>pause()</code> without the parameter) @return self (makes chaining easier) **/
		public function stop():* {
			return paused(true);
		}
		
		/**
		 * @private
		 * [deprecated]
		 * Skips to a particular time, frame, or label and plays the timeline forward from there (unpausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, <code>myTimeline.gotoAndPlay(2)</code> will skip to 2-seconds into a timeline, and <code>myTimeline.gotoAndPlay("myLabel")</code> will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function gotoAndPlay(timeOrLabel:*, suppressEvents:Boolean=true):* {
			return play(timeOrLabel, suppressEvents);
		}
		
		/**
		 * @private
		 * [deprecated]
		 * Skips to a particular time, frame, or label and stops the timeline (pausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, <code>myTimeline.gotoAndStop(2)</code> will skip to 2-seconds into a timeline, and <code>myTimeline.gotoAndStop("myLabel")</code> will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no events or callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered, nor will any of the associated events be dispatched) 
		 */
		public function gotoAndStop(timeOrLabel:*, suppressEvents:Boolean=true):* {
			return pause(timeOrLabel, suppressEvents);
		}
		
		/**
		 * @private
		 * Renders all tweens and sub-timelines in the state they'd be at a particular time (or frame for frames-based timelines). 
		 * 
		 * @param time time in seconds (or frames for frames-based timelines) that should be rendered. 
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 * @param force Normally the tween will skip rendering if the time matches the cachedTotalTime (to improve performance), but if force is true, it forces a render. This is primarily used internally for tweens with durations of zero in TimelineLite/Max instances.
		 */
		override public function render(time:Number, suppressEvents:Boolean=false, force:Boolean=false):void {
			if (_gc) {
				_enabled(true, false);
			} else if (!_active && !_paused) {
				_active = true; 
			}
			var totalDur:Number = (!_dirty) ? _totalDuration : totalDuration(), 
				prevTime:Number = _time, 
				prevStart:Number = _startTime, 
				prevTimeScale:Number = _timeScale, 
				prevPaused:Boolean = _paused,
				tween:Animation, isComplete:Boolean, next:Animation, callback:String;
			if (time >= totalDur) {
				_totalTime = _time = totalDur;
				if (!_reversed) if (!_hasPausedChild()) {
					isComplete = true;
					callback = "onComplete";
					if (_duration == 0) if (time == 0 || _rawPrevTime < 0) if (_rawPrevTime != time) { //In order to accommodate zero-duration timelines, we must discern the momentum/direction of time in order to render values properly when the "playhead" goes past 0 in the forward direction or lands directly on it, and also when it moves past it in the backward direction (from a postitive time to a negative time).
						force = true;
					}
				}
				_rawPrevTime = time;
				time = totalDur + 0.000001; //to avoid occassional floating point rounding errors in Flash - sometimes child tweens/timelines were not being fully completed (their progress might be 0.999999999999998 instead of 1 because when Flash performed _time - tween._startTime, floating point errors would return a value that was SLIGHTLY off)
				
			} else if (time <= 0) {
				_totalTime = _time = 0;
				if (prevTime != 0 || (_duration == 0 && _rawPrevTime > 0)) {
					callback = "onReverseComplete";
					isComplete = _reversed;
				}
				if (time < 0) {
					_active = false;
					if (_duration == 0) if (_rawPrevTime >= 0) { //zero-duration timelines are tricky because we must discern the momentum/direction of time in order to determine whether the starting values should be rendered or the ending values. If the "playhead" of its timeline goes past the zero-duration tween in the forward direction or lands directly on it, the end values should be rendered, but if the timeline's "playhead" moves past it in the backward direction (from a postitive time to a negative time), the starting values must be rendered.
						force = true;
					}
				} else if (!_initted) {
					force = true;
				}
				_rawPrevTime = time;
				time = -0.000001; //to avoid occassional floating point rounding errors in Flash - sometimes child tweens/timelines were not being rendered at the very beginning (their progress might be 0.000000000001 instead of 0 because when Flash performed _time - tween._startTime, floating point errors would return a value that was SLIGHTLY off)
				
			} else {
				_totalTime = _time = _rawPrevTime = time;
			}
			
			if (_time == prevTime && !force) {
				return;
			} else if (!_initted) {
				_initted = true;
			}
			if (prevTime == 0) if (vars.onStart) if (_time != 0) if (!suppressEvents) {
				vars.onStart.apply(null, vars.onStartParams);
			}
			
			if (_time > prevTime) {
				tween = _first;
				while (tween) {
					next = tween._next; //record it here because the value could change after rendering...
					if (_paused && !prevPaused) { //in case a tween pauses the timeline when rendering
						break;
					} else if (tween._active || (tween._startTime <= _time && !tween._paused && !tween._gc)) {
						
						if (!tween._reversed) {
							tween.render((time - tween._startTime) * tween._timeScale, suppressEvents, false);
						} else {
							tween.render(((!tween._dirty) ? tween._totalDuration : tween.totalDuration()) - ((time - tween._startTime) * tween._timeScale), suppressEvents, false);
						}
						
					}
					tween = next;
				}
			} else {
				tween = _last;
				while (tween) {
					next = tween._prev; //record it here because the value could change after rendering...
					if (_paused && !prevPaused) { //in case a tween pauses the timeline when rendering
						break;
					} else if (tween._active || (tween._startTime <= prevTime && !tween._paused && !tween._gc)) {
						
						if (!tween._reversed) {
							tween.render((time - tween._startTime) * tween._timeScale, suppressEvents, false);
						} else {
							tween.render(((!tween._dirty) ? tween._totalDuration : tween.totalDuration()) - ((time - tween._startTime) * tween._timeScale), suppressEvents, false);
						}
						
					}
					tween = next;
				}
			}
			
			if (_onUpdate != null) if (!suppressEvents) {
				_onUpdate.apply(null, vars.onUpdateParams);
			}
			
			if (callback) if (!_gc) if (prevStart == _startTime || prevTimeScale != _timeScale) if (_time == 0 || totalDur >= totalDuration()) { //if one of the tweens that was rendered altered this timeline's startTime (like if an onComplete reversed the timeline), it probably isn't complete. If it is, don't worry, because whatever call altered the startTime would complete if it was necessary at the new time. The only exception is the timeScale property. Also check _gc because there's a chance that kill() could be called in an onUpdate
				if (isComplete) {
					if (_timeline.autoRemoveChildren) {
						_enabled(false, false);
					}
					_active = false;
				}
				if (!suppressEvents) if (vars[callback]) {
					vars[callback].apply(null, vars[callback + "Params"]);
				}
			}
		}
		
		
		/**
		 * @private
		 * Checks the timeline to see if it has any paused children (tweens/timelines). 
		 * 
		 * @return Indicates whether or not the timeline contains any paused children
		 */
		public function _hasPausedChild():Boolean {
			var tween:Animation = _first;
			while (tween) {
				if (tween._paused || ((tween is TimelineLite) && TimelineLite(tween)._hasPausedChild())) {
					return true;
				}
				tween = tween._next;
			}
			return false;
		}		
		
		/**
		 * Returns an array containing all the tweens and/or timelines nested in this timeline.
		 * Callbacks (delayed calls) are considered zero-duration tweens.
		 *  
		 * @param nested Determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to <code>false</code>.
		 * @param tweens Determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
		 * @param timelines Determines whether or not timelines (TimelineLite and TimelineMax instances) should be included in the results
		 * @param ignoreBeforeTime All children with start times that are less than this value will be ignored.
		 * @return an Array containing the child tweens/timelines.
		 */
		public function getChildren(nested:Boolean=true, tweens:Boolean=true, timelines:Boolean=true, ignoreBeforeTime:Number=-9999999999):Array {
			var a:Array = [], 
				tween:Animation = _first, 
				cnt:int = 0;
			while (tween) {
				if (tween._startTime < ignoreBeforeTime) {
					//do nothing
				} else if (tween is TweenLite) {
					if (tweens) {
						a[cnt++] = tween;
					}
				} else {
					if (timelines) {
						a[cnt++] = tween;
					}
					if (nested) {
						a = a.concat(TimelineLite(tween).getChildren(true, tweens, timelines));
						cnt = a.length;
					}
				}
				tween = tween._next;
			}
			return a;
		}
		
		/**
		 * Returns the tweens of a particular object that are inside this timeline.
		 * 
		 * @param target The target object of the tweens
		 * @param nested Determines whether or not tweens that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @return an Array of TweenLite and/or TweenMax instances
		 */
		public function getTweensOf(target:Object, nested:Boolean=true):Array {
			var tweens:Array = TweenLite.getTweensOf(target), 
				i:int = tweens.length, 
				a:Array = [], 
				cnt:int = 0;
			while (--i > -1) {
				if (tweens[i].timeline == this || (nested && _contains(tweens[i]))) {
					a[cnt++] = tweens[i];
				}
			}
			return a;
		}
		
		/** @private **/
		private function _contains(tween:Animation):Boolean {
			var tl:SimpleTimeline = tween.timeline;
			while (tl) {
				if (tl == this) {
					return true;
				}
				tl = tl.timeline;
			}
			return false;
		}
		
		/**
		 * Shifts the startTime of the timeline's children by a certain amount and optionally adjusts labels too. 
		 * This can be useful when you want to prepend children or splice them into a certain spot, moving existing 
		 * ones back to make room for the new ones.
		 * 
		 * @param amount Number of seconds (or frames for frames-based timelines) to move each child.
		 * @param adjustLabels If <code>true</code>, the timing of all labels will be adjusted as well.
		 * @param ignoreBeforeTime All children that begin at or after the <code>startAtTime</code> will be affected by the shift (the default is 0, causing all children to be affected). This provides an easy way to splice children into a certain spot on the timeline, pushing only the children after that point back to make room.
		 * @return self (makes chaining easier)
		 */
		public function shiftChildren(amount:Number, adjustLabels:Boolean=false, ignoreBeforeTime:Number=0):* {
			var tween:Animation = _first;
			while (tween) {
				if (tween._startTime >= ignoreBeforeTime) {
					tween._startTime += amount;
				}
				tween = tween._next;
			}
			if (adjustLabels) {
				for (var p:String in _labels) {
					if (_labels[p] >= ignoreBeforeTime) {
						_labels[p] += amount;
					}
				}
			}
			_uncache(true);
			return this;
		}
		
		/** @private **/
		override public function _kill(vars:Object=null, target:Object=null):Boolean {
			if (vars == null) if (target == null) {
				return _enabled(false, false);
			}
			var tweens:Array = (target == null) ? getChildren(true, true, false) : getTweensOf(target),
				i:int = tweens.length, 
				changed:Boolean = false;
			while (--i > -1) {
				if (tweens[i]._kill(vars, target)) {
					changed = true;
				}
			}
			return changed;
		}
		
		
		/**
		 * Empties the timeline of all tweens, timelines, and callbacks (and optionally labels too).
		 * 
		 * @param labels If <code>true</code> (the default), labels will be cleared too.
		 * @return self (makes chaining easier)
		 */
		public function clear(labels:Boolean=true):* {
			var tweens:Array = getChildren(false, true, true),
				i:int = tweens.length;
			_time = _totalTime = 0;
			while (--i > -1) {
				tweens[i]._enabled(false, false);
			}
			if (labels) {
				_labels = {};
			}
			return _uncache(true);
		}
		
		
		/** @inheritDoc **/
		override public function invalidate():* {
			var tween:Animation = _first;
			while (tween) {
				tween.invalidate();
				tween = tween._next;
			}
			return this;
		}
		
		/** @private **/
		override public function _enabled(enabled:Boolean, ignoreTimeline:Boolean=false):Boolean {
			if (enabled == _gc) {
				var tween:Animation = _first;
				while (tween) {
					tween._enabled(enabled, true);
					tween = tween._next;
				}
			}
			return super._enabled(enabled, ignoreTimeline);
		}
		
		
//---- GETTERS / SETTERS -------------------------------------------------------------------------------------------------------
				
		/** 
		 * Gets or sets the animation's progress which is a value between 0 and 1 indicating the position 
		 * of the virtual playhead where 0 is at the beginning, 0.5 is halfway complete, and 1 is complete. 
		 * 
		 * <p>This method serves as both a getter and setter. Omitting the parameter returns the current 
		 * value (getter), whereas defining the parameter sets the value (setter) and returns the instance 
		 * itself for easier chaining, like <code>myAnimation.progress(0.5).play();</code></p>
		 * 
		 * <listing version="3.0">
 var progress = myAnimation.progress(); //gets current progress
 myAnimation.progress( 0.25 ); //sets progress to one quarter finished
		 </listing>
		 * 
		 * @param value Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * 
		 * @see #seek()
		 * @see #time()
		 * @see #totalTime()
		 **/
		public function progress(value:Number=NaN):* {
			return (!arguments.length) ? _time / duration() : totalTime(duration() * value, false);
		}
		
		/**
		 * Gets the timeline's <code>duration</code> or, if used as a setter, adjusts the timeline's 
		 * <code>timeScale</code> to fit it within the specified duration. For example, if a TimelineMax instance has 
		 * a <code>duration</code> of 2 and a <code>repeat</code> of 3, its <code>totalDuration</code> 
		 * would be 8 (one standard play plus 3 repeats equals 4 total cycles). 
		 * 
		 * <p>Due to the fact that a timeline's <code>duration</code> is dictated by its contents, 
		 * using this method as a setter will simply cause the <code>timeScale</code> to be adjusted
		 * to fit the current contents into the specified <code>duration</code>. For example, 
		 * if there are 20-seconds worth of tweens in the timeline and you do <code>myTimeline.duration(10)</code>,
		 * the <code>timeScale</code> would be changed to 2. If you checked the <code>duration</code> again
		 * immediately after that, it would still return 20 because technically that is how long all the 
		 * child tweens/timelines are but upon playback the speed would be doubled because of the <code>timeScale</code>.</p>
		 * 
		 * <p>This method serves as both a getter and setter. Omitting the parameter returns the current 
		 * value (getter), whereas defining the parameter sets the value (setter) and returns the instance 
		 * itself for easier chaining, like <code>myAnimation.duration(2).play(1);</code></p>
		 * 
		 * <listing version="3.0">
 var currentDuration = myAnimation.duration(); //gets current duration
 myAnimation.duration( 10 ); //adjusts the timeScale of myAnimation so that it fits into exactly 10 seconds on its parent timeline
		 </listing>
		 * @param value Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * 
		 * @see #totalDuration()
		 * @see #timeScale()
		 **/
		override public function duration(value:Number=NaN):* {
			if (!arguments.length) {
				if (_dirty) {
					totalDuration(); //just triggers recalculation
				}
				return _duration;
			}
			if (duration() !== 0) if (value !== 0) {
				timeScale(_duration / value);
			}
			return this;
		}
		
		/**
		 * Gets the timeline's <strong>total</strong> duration or, if used as a setter, adjusts the timeline's 
		 * <code>timeScale</code> to fit it within the specified duration. For example, if a TimelineMax instance has 
		 * a <code>duration</code> of 2 and a <code>repeat</code> of 3, its <code>totalDuration</code> 
		 * would be 8 (one standard play plus 3 repeats equals 4 total cycles). 
		 * 
		 * <p>Due to the fact that a timeline's <code>totalDuration</code> is dictated by its contents, 
		 * using this method as a setter will simply cause the <code>timeScale</code> to be adjusted
		 * to fit the current contents into the specified <code>totalDuration</code>. For example, 
		 * if there are 20-seconds worth of tweens in the timeline and you do <code>myTimeline.totalDuration(10)</code>,
		 * the <code>timeScale</code> would be changed to 2. If you checked the <code>totalDuration</code> again
		 * immediately after that, it would still return 20 because technically that is how long all the 
		 * child tweens/timelines are but upon playback the speed would be doubled because of the 
		 * <code>timeScale</code>.</p>
		 * 
		 * <p>This method serves as both a getter and setter. Omitting the parameter returns the current 
		 * value (getter), whereas defining the parameter sets the value (setter) and returns the instance 
		 * itself for easier chaining, like <code>myAnimation.totalDuration(2).play(1);</code></p>
		 * 
		 * <listing version="3.0">
var ctd = myAnimation.totalDuration(); //gets current total duration
myAnimation.totalDuration( 20 ); //adjusts the timeScale so that myAnimation fits into exactly 20 seconds on its parent timeline
</listing>
		 * @param value Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
		 * 
		 * @see #timeScale()
		 * @see #duration()
		 **/
		override public function totalDuration(value:Number=NaN):* {
			if (!arguments.length) {
				if (_dirty) {
					var max:Number = 0, end:Number, tween:Animation = _first, prevStart:Number = -Infinity, next:Animation;
					while (tween) {
						next = tween._next; //record it here in case the tween changes position in the sequence...
						if (tween._startTime < prevStart && _sortChildren) { //in case one of the tweens shifted out of order, it needs to be re-inserted into the correct position in the sequence
							insert(tween, tween._startTime - tween._delay);
						} else {
							prevStart = tween._startTime;
						}
						if (tween._startTime < 0) {//children aren't allowed to have negative startTimes, so adjust here if one is found.
							max -= tween._startTime;
							shiftChildren(-tween._startTime, false, -9999999999);
						}
						end = tween._startTime + ((!tween._dirty ? tween._totalDuration : tween.totalDuration()) / tween._timeScale);
						if (end > max) {
							max = end;
						}
						tween = next;
					}
					_duration = _totalDuration = max;
					_dirty = false;
				}
				return _totalDuration;
			}
			if (totalDuration() != 0) if (value != 0) {
				timeScale( _totalDuration / value );
			}
			return this;
		}
		
		/** 
		 * [READ-ONLY] If <code>true</code>, the timeline's timing mode is frames-based instead of
		 * seconds. This can only be set to <code>true</code> by passing <code>useFrames:true</code> in 
		 * the vars parameter of the constructor, or by nesting this timeline in another whose 
		 * timing mode is frames-based. An animation's timing mode is always determined by its parent timeline).
		 **/
		public function usesFrames():Boolean {
			var tl:SimpleTimeline = _timeline;
			while (tl._timeline) {
				tl = tl._timeline;
			}
			return (tl == _rootFramesTimeline);
		}
		
		/**
		 * @private
		 * Reports the totalTime of the timeline without capping the number at the <code>totalDuration</code> (max) 
		 * and zero (minimum) which can be useful when unpausing tweens/timelines. Imagine a case where a paused 
		 * tween is in a timeline that has already reached the end, but then the tween gets unpaused - it needs a 
		 * way to place itself accurately in time AFTER what was previously the timeline's end time.
		 * 
		 * @return The <code>totalTime</code> of the timeline without capping the number at the <code>totalDuration</code> (max) and zero (minimum)
		 */
		override public function rawTime():Number {
			return (_paused || (_totalTime !== 0 && _totalTime !== _totalDuration)) ? _totalTime : (_timeline.rawTime() - _startTime) * _timeScale;
		}
		
		
	}
}