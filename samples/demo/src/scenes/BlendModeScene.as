package scenes
{
    import starling.display.BlendModeStarling;
    import starling.display.ButtonStarling;
    import starling.display.ImageStarling;
    import starling.events.EventStarling;
    import starling.text.TextFieldStarling;

    public class BlendModeScene extends Scene
    {
        private var mButton:ButtonStarling;
        private var mImage:ImageStarling;
        private var mInfoText:TextFieldStarling;
        
        private var mBlendModes:Array = [
            BlendModeStarling.NORMAL,
            BlendModeStarling.MULTIPLY,
            BlendModeStarling.SCREEN,
            BlendModeStarling.ADD,
            BlendModeStarling.ERASE,
            BlendModeStarling.NONE
        ];
        
        public function BlendModeScene()
        {
            mButton = new ButtonStarling(Game.assets.getTexture("button_normal"), "Switch Mode");
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
            
            onButtonTriggered();
        }
        
        private function onButtonTriggered():void
        {
            var blendMode:String = mBlendModes.shift() as String;
            mBlendModes.push(blendMode);
            
            mInfoText.text = blendMode;
            mImage.blendMode = blendMode;
        }
    }
}