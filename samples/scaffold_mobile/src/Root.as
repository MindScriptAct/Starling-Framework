package
{
    import flash.system.System;
    
    import starling.core.StarlingStarling;
    import starling.display.ImageStarling;
    import starling.display.SpriteStarling;
    import starling.events.EventStarling;
    import starling.textures.TextureStarling;
    import starling.utils.AssetManagerStarling;
    
    import utils.ProgressBar;

    /** The Root class is the topmost display object in your game. It loads all the assets
     *  and displays a progress bar while this is happening. Later, it is responsible for
     *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
     *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
     *  controls the high level behaviour of your game. */
    public class Root extends SpriteStarling
    {
        private static var sAssets:AssetManagerStarling;
        
        private var mActiveScene:SpriteStarling;
        
        public function Root()
        {
            addEventListener(Menu.START_GAME, onStartGame);
            addEventListener(Game.GAME_OVER,  onGameOver);
            
            // not more to do here -- Startup will call "start" immediately.
        }
        
        public function start(background:TextureStarling, assets:AssetManagerStarling):void
        {
            // the asset manager is saved as a static variable; this allows us to easily access
            // all the assets from everywhere by simply calling "Root.assets"
            sAssets = assets;
            
            // The background is passed into this method for two reasons:
            // 
            // 1) we need it right away, otherwise we have an empty frame
            // 2) the Startup class can decide on the right image, depending on the device.
            
            addChild(new ImageStarling(background));
            
            // The AssetManager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator. 
            
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (background.width  - progressBar.width)  / 2;
            progressBar.y = (background.height - progressBar.height) / 2;
            progressBar.y = background.height * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay. 
                
                if (ratio == 1)
                    StarlingStarling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
                        showScene(Menu);
                        
                        // now would be a good time for a clean-up 
                        System.pauseForGCIfCollectionImminent(0);
                        System.gc();
                    }, 0.15);
            });
        }
        
        private function onGameOver(event:EventStarling, score:int):void
        {
            trace("Game Over! Score: " + score);
            showScene(Menu);
        }
        
        private function onStartGame(event:EventStarling, gameMode:String):void
        {
            trace("Game starts! Mode: " + gameMode);
            showScene(Game);
        }
        
        private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        
        public static function get assets():AssetManagerStarling { return sAssets; }
    }
}