// =================================================================================================
//
//	Starling Framework
//	Copyright 2011 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package tests
{
    import flexunit.framework.Assert;
    
    import starling.display.SpriteStarling;
    import starling.events.EventStarling;
    import starling.events.EventDispatcherStarling;
    
    public class EventTest
    {		
        [Test]
        public function testBubbling():void
        {
            const eventType:String = "test";
            
            var grandParent:SpriteStarling = new SpriteStarling();
            var parent:SpriteStarling = new SpriteStarling();
            var child:SpriteStarling = new SpriteStarling();
            
            grandParent.addChild(parent);
            parent.addChild(child);
            
            var grandParentEventHandlerHit:Boolean = false;
            var parentEventHandlerHit:Boolean = false;
            var childEventHandlerHit:Boolean = false;
            var hitCount:int = 0;            
            
            // bubble up
            
            grandParent.addEventListener(eventType, onGrandParentEvent);
            parent.addEventListener(eventType, onParentEvent);
            child.addEventListener(eventType, onChildEvent);
            
            var event:EventStarling = new EventStarling(eventType, true);
            child.dispatchEvent(event);
            
            Assert.assertTrue(grandParentEventHandlerHit);
            Assert.assertTrue(parentEventHandlerHit);
            Assert.assertTrue(childEventHandlerHit);
            
            Assert.assertEquals(3, hitCount);
            
            // remove event handler
            
            parentEventHandlerHit = false;
            parent.removeEventListener(eventType, onParentEvent);
            child.dispatchEvent(event);
            
            Assert.assertFalse(parentEventHandlerHit);
            Assert.assertEquals(5, hitCount);
            
            // don't bubble
            
            event = new EventStarling(eventType);
            
            grandParentEventHandlerHit = parentEventHandlerHit = childEventHandlerHit = false;
            parent.addEventListener(eventType, onParentEvent);
            child.dispatchEvent(event);
            
            Assert.assertEquals(6, hitCount);
            Assert.assertTrue(childEventHandlerHit);
            Assert.assertFalse(parentEventHandlerHit);
            Assert.assertFalse(grandParentEventHandlerHit);
            
            function onGrandParentEvent(event:EventStarling):void
            {
                grandParentEventHandlerHit = true;                
                Assert.assertEquals(child, event.target);
                Assert.assertEquals(grandParent, event.currentTarget);
                hitCount++;
            }
            
            function onParentEvent(event:EventStarling):void
            {
                parentEventHandlerHit = true;                
                Assert.assertEquals(child, event.target);
                Assert.assertEquals(parent, event.currentTarget);
                hitCount++;
            }
            
            function onChildEvent(event:EventStarling):void
            {
                childEventHandlerHit = true;                               
                Assert.assertEquals(child, event.target);
                Assert.assertEquals(child, event.currentTarget);
                hitCount++;
            }
        }
        
        [Test]
        public function testStopPropagation():void
        {
            const eventType:String = "test";
            
            var grandParent:SpriteStarling = new SpriteStarling();
            var parent:SpriteStarling = new SpriteStarling();
            var child:SpriteStarling = new SpriteStarling();
            
            grandParent.addChild(parent);
            parent.addChild(child);
            
            var hitCount:int = 0;
            
            // stop propagation at parent
            
            child.addEventListener(eventType, onEvent);
            parent.addEventListener(eventType, onEvent_StopPropagation);
            parent.addEventListener(eventType, onEvent);
            grandParent.addEventListener(eventType, onEvent);
            
            child.dispatchEvent(new EventStarling(eventType, true));
            
            Assert.assertEquals(3, hitCount);
            
            // stop immediate propagation at parent
            
            parent.removeEventListener(eventType, onEvent_StopPropagation);
            parent.removeEventListener(eventType, onEvent);
            
            parent.addEventListener(eventType, onEvent_StopImmediatePropagation);
            parent.addEventListener(eventType, onEvent);
            
            child.dispatchEvent(new EventStarling(eventType, true));
            
            Assert.assertEquals(5, hitCount);
            
            function onEvent(event:EventStarling):void
            {
                hitCount++;
            }
            
            function onEvent_StopPropagation(event:EventStarling):void
            {
                event.stopPropagation();
                hitCount++;
            }
            
            function onEvent_StopImmediatePropagation(event:EventStarling):void
            {
                event.stopImmediatePropagation();
                hitCount++;
            }
        }
        
        [Test]
        public function testRemoveEventListeners():void
        {
            var hitCount:int = 0;
            var dispatcher:EventDispatcherStarling = new EventDispatcherStarling();
            
            dispatcher.addEventListener("Type1", onEvent);
            dispatcher.addEventListener("Type2", onEvent);
            dispatcher.addEventListener("Type3", onEvent);
            
            hitCount = 0;
            dispatcher.dispatchEvent(new EventStarling("Type1"));
            Assert.assertEquals(1, hitCount);
            
            dispatcher.dispatchEvent(new EventStarling("Type2"));
            Assert.assertEquals(2, hitCount);
            
            dispatcher.dispatchEvent(new EventStarling("Type3"));
            Assert.assertEquals(3, hitCount);
            
            hitCount = 0;
            dispatcher.removeEventListener("Type1", onEvent);
            dispatcher.dispatchEvent(new EventStarling("Type1"));
            Assert.assertEquals(0, hitCount);
            
            dispatcher.dispatchEvent(new EventStarling("Type3"));
            Assert.assertEquals(1, hitCount);
            
            hitCount = 0;
            dispatcher.removeEventListeners();
            dispatcher.dispatchEvent(new EventStarling("Type1"));
            dispatcher.dispatchEvent(new EventStarling("Type2"));
            dispatcher.dispatchEvent(new EventStarling("Type3"));
            Assert.assertEquals(0, hitCount);
            
            function onEvent(event:EventStarling):void
            {
                ++hitCount;
            }
        }
        
        [Test]
        public function testBlankEventDispatcher():void
        {
            var dispatcher:EventDispatcherStarling = new EventDispatcherStarling();
            
            Helpers.assertDoesNotThrow(function():void
            {
                dispatcher.removeEventListener("Test", null);
            });
            
            Helpers.assertDoesNotThrow(function():void
            {
                dispatcher.removeEventListeners("Test");
            });
        }
        
        [Test]
        public function testDuplicateEventHandler():void
        {
            var dispatcher:EventDispatcherStarling = new EventDispatcherStarling();
            var callCount:int = 0;
            
            dispatcher.addEventListener("test", onEvent);
            dispatcher.addEventListener("test", onEvent);
            
            dispatcher.dispatchEvent(new EventStarling("test"));
            Assert.assertEquals(1, callCount);
            
            function onEvent(event:EventStarling):void
            {
                callCount++;
            }
        }
        
        [Test]
        public function testBubbleWithModifiedChain():void
        {
            const eventType:String = "test";
            
            var grandParent:SpriteStarling = new SpriteStarling();
            var parent:SpriteStarling = new SpriteStarling();
            var child:SpriteStarling = new SpriteStarling();
            
            grandParent.addChild(parent);
            parent.addChild(child);
            
            var hitCount:int = 0;
            
            // listener on 'child' changes display list; bubbling must not be affected.
            
            grandParent.addEventListener(eventType, onEvent);
            parent.addEventListener(eventType, onEvent);
            child.addEventListener(eventType, onEvent);
            child.addEventListener(eventType, onEvent_removeFromParent);
            
            child.dispatchEvent(new EventStarling(eventType, true));
            
            Assert.assertNull(parent.parent);
            Assert.assertEquals(3, hitCount);
            
            function onEvent():void
            {
                hitCount++;
            }
            
            function onEvent_removeFromParent():void
            {
                parent.removeFromParent();
            }
        }
        
        [Test]
        public function testRedispatch():void
        {
            const eventType:String = "test";
            
            var grandParent:SpriteStarling = new SpriteStarling();
            var parent:SpriteStarling = new SpriteStarling();
            var child:SpriteStarling = new SpriteStarling();
            
            grandParent.addChild(parent);
            parent.addChild(child);
            
            grandParent.addEventListener(eventType, onEvent);
            parent.addEventListener(eventType, onEvent);
            child.addEventListener(eventType, onEvent);
            parent.addEventListener(eventType, onEvent_redispatch);
            
            var targets:Array = [];
            var currentTargets:Array = [];
            
            child.dispatchEventWith(eventType, true);
            
            // main bubble
            Assert.assertEquals(targets[0], child);
            Assert.assertEquals(currentTargets[0], child);
            
            // main bubble
            Assert.assertEquals(targets[1], child);
            Assert.assertEquals(currentTargets[1], parent);
            
            // inner bubble
            Assert.assertEquals(targets[2], parent);
            Assert.assertEquals(currentTargets[2], parent);
            
            // inner bubble
            Assert.assertEquals(targets[3], parent);
            Assert.assertEquals(currentTargets[3], grandParent);
            
            // main bubble
            Assert.assertEquals(targets[4], child);
            Assert.assertEquals(currentTargets[4], grandParent);
            
            function onEvent(event:EventStarling):void
            {
                targets.push(event.target);
                currentTargets.push(event.currentTarget);
            }
            
            function onEvent_redispatch(event:EventStarling):void
            {
                parent.removeEventListener(eventType, onEvent_redispatch);
                parent.dispatchEvent(event);
            }
        }
    }
}
