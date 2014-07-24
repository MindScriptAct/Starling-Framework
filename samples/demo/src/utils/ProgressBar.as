package utils
{
    import flash.display.BitmapData;
    import flash.display.Shape;
    
    import starling.core.StarlingStarling;
    import starling.display.ImageStarling;
    import starling.display.QuadStarling;
    import starling.display.SpriteStarling;
    import starling.textures.TextureStarling;

    public class ProgressBar extends SpriteStarling
    {
        private var mBar:QuadStarling;
        private var mBackground:ImageStarling;
        
        public function ProgressBar(width:int, height:int)
        {
            init(width, height);
        }
        
        private function init(width:int, height:int):void
        {
            var scale:Number = StarlingStarling.contentScaleFactor;
            var padding:Number = height * 0.2;
            var cornerRadius:Number = padding * scale * 2;
            
            // create black rounded box for background
            
            var bgShape:Shape = new Shape();
            bgShape.graphics.beginFill(0x0, 0.5);
            bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
            bgShape.graphics.endFill();
            
            var bgBitmapData:BitmapData = new BitmapData(width*scale, height*scale, true, 0x0);
            bgBitmapData.draw(bgShape);
            var bgTexture:TextureStarling = TextureStarling.fromBitmapData(bgBitmapData, false, false, scale);
            
            mBackground = new ImageStarling(bgTexture);
            addChild(mBackground);
            
            // create progress bar quad
            
            mBar = new QuadStarling(width - 2*padding, height - 2*padding, 0xeeeeee);
            mBar.setVertexColor(2, 0xaaaaaa);
            mBar.setVertexColor(3, 0xaaaaaa);
            mBar.x = padding;
            mBar.y = padding;
            mBar.scaleX = 0;
            addChild(mBar);
        }
        
        public function get ratio():Number { return mBar.scaleX; }
        public function set ratio(value:Number):void 
        { 
            mBar.scaleX = Math.max(0.0, Math.min(1.0, value)); 
        }
    }
}