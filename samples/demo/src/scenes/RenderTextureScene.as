package scenes
{
    import flash.geom.Point;
    import flash.utils.Dictionary;
    
    import starling.display.BlendModeStarling;
    import starling.display.ButtonStarling;
    import starling.display.ImageStarling;
    import starling.events.EventStarling;
    import starling.events.TouchStarling;
    import starling.events.TouchEventStarling;
    import starling.events.TouchPhaseStarling;
    import starling.text.TextFieldStarling;
    import starling.textures.RenderTextureStarling;

    public class RenderTextureScene extends Scene
    {
        private var mRenderTexture:RenderTextureStarling;
        private var mCanvas:ImageStarling;
        private var mBrush:ImageStarling;
        private var mButton:ButtonStarling;
        private var mColors:Dictionary;
        
        public function RenderTextureScene()
        {
            mColors = new Dictionary();
            mRenderTexture = new RenderTextureStarling(320, 435);
            
            mCanvas = new ImageStarling(mRenderTexture);
            mCanvas.addEventListener(TouchEventStarling.TOUCH, onTouch);
            addChild(mCanvas);
            
            mBrush = new ImageStarling(Game.assets.getTexture("brush"));
            mBrush.pivotX = mBrush.width / 2;
            mBrush.pivotY = mBrush.height / 2;
            mBrush.blendMode = BlendModeStarling.NORMAL;
            
            var infoText:TextFieldStarling = new TextFieldStarling(256, 128, "Touch the screen\nto draw!");
            infoText.fontSize = 24;
            infoText.x = Constants.CenterX - infoText.width / 2;
            infoText.y = Constants.CenterY - infoText.height / 2;
            mRenderTexture.draw(infoText);
            
            mButton = new ButtonStarling(Game.assets.getTexture("button_normal"), "Mode: Draw");
            mButton.x = int(Constants.CenterX - mButton.width / 2);
            mButton.y = 15;
            mButton.addEventListener(EventStarling.TRIGGERED, onButtonTriggered);
            addChild(mButton);
        }
        
        private function onTouch(event:TouchEventStarling):void
        {
            // touching the canvas will draw a brush texture. The 'drawBundled' method is not
            // strictly necessary, but it's faster when you are drawing with several fingers
            // simultaneously.
            
            mRenderTexture.drawBundled(function():void
            {
                var touches:Vector.<TouchStarling> = event.getTouches(mCanvas);
            
                for each (var touch:TouchStarling in touches)
                {
                    if (touch.phase == TouchPhaseStarling.BEGAN)
                        mColors[touch.id] = Math.random() * uint.MAX_VALUE;
                    
                    if (touch.phase == TouchPhaseStarling.HOVER || touch.phase == TouchPhaseStarling.ENDED)
                        continue;
                    
                    var location:Point = touch.getLocation(mCanvas);
                    mBrush.x = location.x;
                    mBrush.y = location.y;
                    mBrush.color = mColors[touch.id];
                    mBrush.rotation = Math.random() * Math.PI * 2.0;
                    
                    mRenderTexture.draw(mBrush);
                }
            });
        }
        
        private function onButtonTriggered():void
        {
            if (mBrush.blendMode == BlendModeStarling.NORMAL)
            {
                mBrush.blendMode = BlendModeStarling.ERASE;
                mButton.text = "Mode: Erase";
            }
            else
            {
                mBrush.blendMode = BlendModeStarling.NORMAL;
                mButton.text = "Mode: Draw";
            }
        }
        
        public override function dispose():void
        {
            mRenderTexture.dispose();
            super.dispose();
        }
    }
}