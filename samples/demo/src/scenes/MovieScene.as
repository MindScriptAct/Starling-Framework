package scenes
{
    import flash.media.Sound;
    
    import starling.core.StarlingStarling;
    import starling.display.MovieClipStarling;
    import starling.events.EventStarling;
    import starling.textures.TextureStarling;

    public class MovieScene extends Scene
    {
        private var mMovie:MovieClipStarling;
        
        public function MovieScene()
        {
            var frames:Vector.<TextureStarling> = Game.assets.getTextures("flight");
            mMovie = new MovieClipStarling(frames, 15);
            
            // add sounds
            var stepSound:Sound = Game.assets.getSound("wing_flap");
            mMovie.setFrameSound(2, stepSound);
            
            // move the clip to the center and add it to the stage
            mMovie.x = Constants.CenterX - int(mMovie.width / 2);
            mMovie.y = Constants.CenterY - int(mMovie.height / 2);
            addChild(mMovie);
            
            // like any animation, the movie needs to be added to the juggler!
            // this is the recommended way to do that.
            addEventListener(EventStarling.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(EventStarling.REMOVED_FROM_STAGE, onRemovedFromStage);
        }
        
        private function onAddedToStage():void
        {
            StarlingStarling.juggler.add(mMovie);
        }
        
        private function onRemovedFromStage():void
        {
            StarlingStarling.juggler.remove(mMovie);
        }
        
        public override function dispose():void
        {
            removeEventListener(EventStarling.REMOVED_FROM_STAGE, onRemovedFromStage);
            removeEventListener(EventStarling.ADDED_TO_STAGE, onAddedToStage);
            super.dispose();
        }
    }
}