package scenes
{
    import starling.display.ButtonStarling;
    import starling.display.SpriteStarling;
    
    public class Scene extends SpriteStarling
    {
        private var mBackButton:ButtonStarling;
        
        public function Scene()
        {
            // the main menu listens for TRIGGERED events, so we just need to add the button.
            // (the event will bubble up when it's dispatched.)
            
            mBackButton = new ButtonStarling(Game.assets.getTexture("button_back"), "Back");
            mBackButton.x = Constants.CenterX - mBackButton.width / 2;
            mBackButton.y = Constants.GameHeight - mBackButton.height + 1;
            mBackButton.name = "backButton";
            addChild(mBackButton);
        }
    }
}