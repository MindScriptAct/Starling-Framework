package 
{
    import starling.animation.TransitionsStarling;
    import starling.core.StarlingStarling;
    import starling.display.ImageStarling;
    import starling.display.SpriteStarling;
    import starling.events.TouchEventStarling;
    import starling.events.TouchPhaseStarling;
    import starling.utils.deg2radStarling;

    /** The Game class represents the actual game. In this scaffold, it just displays a 
     *  Starling that moves around fast. When the user touches the Starling, the game ends. */ 
    public class Game extends SpriteStarling
    {
        public static const GAME_OVER:String = "gameOver";
        
        private var mBird:ImageStarling;
        
        public function Game()
        {
            init();
        }
        
        private function init():void
        {
            mBird = new ImageStarling(Root.assets.getTexture("starling_rocket"));
            mBird.pivotX = mBird.width / 2;
            mBird.pivotY = mBird.height / 2;
            mBird.x = Constants.STAGE_WIDTH / 2;
            mBird.y = Constants.STAGE_HEIGHT / 2;
            mBird.addEventListener(TouchEventStarling.TOUCH, onBirdTouched);
            addChild(mBird);
            
            moveBird();
        }
        
        private function moveBird():void
        {
            var scale:Number = Math.random() * 0.8 + 0.2;
            
            StarlingStarling.juggler.tween(mBird, Math.random() * 0.5 + 0.5, {
                x: Math.random() * Constants.STAGE_WIDTH,
                y: Math.random() * Constants.STAGE_HEIGHT,
                scaleX: scale,
                scaleY: scale,
                rotation: Math.random() * deg2radStarling(180) - deg2radStarling(90),
                transition: TransitionsStarling.EASE_IN_OUT,
                onComplete: moveBird
            });
        }
        
        private function onBirdTouched(event:TouchEventStarling):void
        {
            if (event.getTouch(mBird, TouchPhaseStarling.BEGAN))
            {
                Root.assets.playSound("click");
                StarlingStarling.juggler.removeTweens(mBird);
                dispatchEventWith(GAME_OVER, true, 100);
            }
        }
    }
}