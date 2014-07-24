package scenes
{
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    
    import starling.core.StarlingStarling;
    import starling.display.ButtonStarling;
    import starling.display.ImageStarling;
    import starling.events.EventStarling;
    import starling.filters.BlurFilterStarling;
    import starling.filters.ColorMatrixFilterStarling;
    import starling.filters.DisplacementMapFilterStarling;
    import starling.text.TextFieldStarling;
    import starling.textures.TextureStarling;

    public class FilterScene extends Scene
    {
        private var mButton:ButtonStarling;
        private var mImage:ImageStarling;
        private var mInfoText:TextFieldStarling;
        private var mFilterInfos:Array;
        
        public function FilterScene()
        {
            mButton = new ButtonStarling(Game.assets.getTexture("button_normal"), "Switch Filter");
            mButton.x = int(Constants.CenterX - mButton.width / 2);
            mButton.y = 15;
            mButton.addEventListener(EventStarling.TRIGGERED, onButtonTriggered);
            addChild(mButton);
            
            mImage = new ImageStarling(Game.assets.getTexture("starling_rocket"));
            mImage.x = int(Constants.CenterX - mImage.width / 2);
            mImage.y = 170;
            addChild(mImage);
            
            mInfoText = new TextFieldStarling(300, 32, "", "Verdana", 19);
            mInfoText.x = 10;
            mInfoText.y = 330;
            addChild(mInfoText);
            
            initFilters();
            onButtonTriggered();
        }
        
        private function onButtonTriggered():void
        {
            var filterInfo:Array = mFilterInfos.shift() as Array;
            mFilterInfos.push(filterInfo);
            
            mInfoText.text = filterInfo[0];
            mImage.filter  = filterInfo[1];
        }
        
        private function initFilters():void
        {
            mFilterInfos = [
                ["Identity", new ColorMatrixFilterStarling()],
                ["Blur", new BlurFilterStarling()],
                ["Drop Shadow", BlurFilterStarling.createDropShadow()],
                ["Glow", BlurFilterStarling.createGlow()]
            ];
            
            var displacementFilter:DisplacementMapFilterStarling = new DisplacementMapFilterStarling(
                createDisplacementMap(mImage.width, mImage.height), null,
                BitmapDataChannel.RED, BitmapDataChannel.GREEN, 25, 25);
            mFilterInfos.push(["Displacement Map", displacementFilter]);
            
            var invertFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            invertFilter.invert();
            mFilterInfos.push(["Invert", invertFilter]);
            
            var grayscaleFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            grayscaleFilter.adjustSaturation(-1);
            mFilterInfos.push(["Grayscale", grayscaleFilter]);
            
            var saturationFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            saturationFilter.adjustSaturation(1);
            mFilterInfos.push(["Saturation", saturationFilter]);
            
            var contrastFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            contrastFilter.adjustContrast(0.75);
            mFilterInfos.push(["Contrast", contrastFilter]);

            var brightnessFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            brightnessFilter.adjustBrightness(-0.25);
            mFilterInfos.push(["Brightness", brightnessFilter]);

            var hueFilter:ColorMatrixFilterStarling = new ColorMatrixFilterStarling();
            hueFilter.adjustHue(1);
            mFilterInfos.push(["Hue", hueFilter]);
        }
        
        private function createDisplacementMap(width:Number, height:Number):TextureStarling
        {
            var scale:Number = StarlingStarling.contentScaleFactor;
            var map:BitmapData = new BitmapData(width*scale, height*scale, false);
            map.perlinNoise(20*scale, 20*scale, 3, 5, false, true);
            var texture:TextureStarling = TextureStarling.fromBitmapData(map, false, false, scale);
            return texture;
        }
    }
}