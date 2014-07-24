package scenes
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import starling.core.StarlingStarling;
    import starling.display.ImageStarling;
    import starling.display.QuadStarling;
    import starling.display.SpriteStarling;
    import starling.events.TouchStarling;
    import starling.events.TouchEventStarling;
    import starling.events.TouchPhaseStarling;
    import starling.filters.ColorMatrixFilterStarling;
    import starling.text.TextFieldStarling;

    public class MaskScene extends Scene
    {
        private var mContents:SpriteStarling;
        private var mClipQuad:QuadStarling;
        
        public function MaskScene()
        {
            mContents = new SpriteStarling();
            addChild(mContents);
            
            var stageWidth:Number  = StarlingStarling.current.stage.stageWidth;
            var stageHeight:Number = StarlingStarling.current.stage.stageHeight;
            
            var touchQuad:QuadStarling = new QuadStarling(stageWidth, stageHeight);
            touchQuad.alpha = 0; // only used to get touch events
            addChildAt(touchQuad, 0);
            
            var image:ImageStarling = new ImageStarling(Game.assets.getTexture("flight_00"));
            image.x = (stageWidth - image.width) / 2;
            image.y = 80;
            mContents.addChild(image);
            
            // just to prove it works, use a filter on the image.
            var cm:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            cm.adjustHue(-0.5);
            image.filter = cm;
            
            var scissorText:TextFieldStarling = new TextFieldStarling(256, 128,
                "Move the mouse (or a finger) over the screen to move the clipping rectangle.");
            scissorText.x = (stageWidth - scissorText.width) / 2;
            scissorText.y = 240;
            mContents.addChild(scissorText);
            
            var maskText:TextFieldStarling = new TextFieldStarling(256, 128,
                "Currently, Starling supports only stage-aligned clipping; more complex masks " +
                "will be supported in future versions.");
            maskText.x = scissorText.x;
            maskText.y = 290;
            mContents.addChild(maskText);
            
            var scissorRect:Rectangle = new Rectangle(0, 0, 150, 150); 
            scissorRect.x = (stageWidth  - scissorRect.width)  / 2;
            scissorRect.y = (stageHeight - scissorRect.height) / 2 + 5;
            mContents.clipRect = scissorRect;
            
            mClipQuad = new QuadStarling(scissorRect.width, scissorRect.height, 0xff0000);
            mClipQuad.x = scissorRect.x;
            mClipQuad.y = scissorRect.y;
            mClipQuad.alpha = 0.1;
            mClipQuad.touchable = false;
            addChild(mClipQuad);
            
            addEventListener(TouchEventStarling.TOUCH, onTouch);
        }
        
        private function onTouch(event:TouchEventStarling):void
        {
            var touch:TouchStarling = event.getTouch(this, TouchPhaseStarling.HOVER) ||
                              event.getTouch(this, TouchPhaseStarling.BEGAN) ||
                              event.getTouch(this, TouchPhaseStarling.MOVED);

            if (touch)
            {
                var localPos:Point = touch.getLocation(this);
                var clipRect:Rectangle = mContents.clipRect;
                clipRect.x = localPos.x - clipRect.width  / 2;
                clipRect.y = localPos.y - clipRect.height / 2;
                
                mClipQuad.x = clipRect.x;
                mClipQuad.y = clipRect.y;
            }
        }
    }
}