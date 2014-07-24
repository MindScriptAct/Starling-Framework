package scenes
{
    import starling.display.ImageStarling;
    import starling.text.TextFieldStarling;
    import starling.utils.deg2radStarling;
    
    import utils.TouchSheet;

    public class TouchScene extends Scene
    {
        public function TouchScene()
        {
            var description:String = "[use Ctrl/Cmd & Shift to simulate multi-touch]";
            
            var infoText:TextFieldStarling = new TextFieldStarling(300, 25, description);
            infoText.x = infoText.y = 10;
            addChild(infoText);
            
            // to find out how to react to touch events have a look at the TouchSheet class! 
            // It's part of the demo.
            
            var sheet:TouchSheet = new TouchSheet(new ImageStarling(Game.assets.getTexture("starling_sheet")));
            sheet.x = Constants.CenterX;
            sheet.y = Constants.CenterY;
            sheet.rotation = deg2radStarling(10);
            addChild(sheet);
        }
    }
}