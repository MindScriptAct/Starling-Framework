package 
{
    import flash.display.Sprite;
    import flash.system.Capabilities;
    
    import starling.core.StarlingStarling;
    import starling.events.EventStarling;
    import starling.textures.TextureStarling;
    import starling.utils.AssetManagerStarling;
    
    // If you set this class as your 'default application', it will run without a preloader.
    // To use a preloader, see 'Demo_Web_Preloader.as'.
    
    [SWF(width="320", height="480", frameRate="60", backgroundColor="#222222")]
    public class Demo_Web extends Sprite
    {
        [Embed(source = "/startup.jpg")]
        private var Background:Class;
        
        private var mStarling:StarlingStarling;
        
        public function Demo_Web()
        {
            if (stage) start();
            else addEventListener(EventStarling.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function start():void
        {
            StarlingStarling.multitouchEnabled = true; // for Multitouch Scene
            StarlingStarling.handleLostContext = true; // required on Windows, needs more memory
            
            mStarling = new StarlingStarling(Game, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.addEventListener(EventStarling.ROOT_CREATED, onRootCreated);
        }
        
        private function onAddedToStage(event:Object):void
        {
            removeEventListener(EventStarling.ADDED_TO_STAGE, onAddedToStage);
            start();
        }
        
        private function onRootCreated(event:EventStarling, game:Game):void
        {
            // set framerate to 30 in software mode
            if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                mStarling.nativeStage.frameRate = 30;
            
            // define which resources to load
            var assets:AssetManagerStarling = new AssetManagerStarling();
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(EmbeddedAssets);
            
            // background texture is embedded, because we need it right away!
            var bgTexture:TextureStarling = TextureStarling.fromEmbeddedAsset(Background, false);
            
            // game will first load resources, then start menu
            game.start(bgTexture, assets);
        }
    }
}