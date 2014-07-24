package
{
    import flash.utils.getQualifiedClassName;
    
    import scenes.AnimationScene;
    import scenes.BenchmarkScene;
    import scenes.BlendModeScene;
    import scenes.CustomHitTestScene;
    import scenes.FilterScene;
    import scenes.MaskScene;
    import scenes.MovieScene;
    import scenes.RenderTextureScene;
    import scenes.TextScene;
    import scenes.TextureScene;
    import scenes.TouchScene;
    
    import starling.core.StarlingStarling;
    import starling.display.ButtonStarling;
    import starling.display.ImageStarling;
    import starling.display.SpriteStarling;
    import starling.events.TouchEventStarling;
    import starling.events.TouchPhaseStarling;
    import starling.text.TextFieldStarling;
    import starling.textures.TextureStarling;
    import starling.utils.VAlignStarling;

    public class MainMenu extends SpriteStarling
    {
        public function MainMenu()
        {
            init();
        }
        
        private function init():void
        {
            var logo:ImageStarling = new ImageStarling(Game.assets.getTexture("logo"));
            addChild(logo);
            
            var scenesToCreate:Array = [
                ["Textures", TextureScene],
                ["Multitouch", TouchScene],
                ["TextFields", TextScene],
                ["Animations", AnimationScene],
                ["Custom hit-test", CustomHitTestScene],
                ["Movie Clip", MovieScene],
                ["Filters", FilterScene],
                ["Blend Modes", BlendModeScene],
                ["Render Texture", RenderTextureScene],
                ["Benchmark", BenchmarkScene],
                ["Clipping", MaskScene]
            ];
            
            var buttonTexture:TextureStarling = Game.assets.getTexture("button_medium");
            var count:int = 0;
            
            for each (var sceneToCreate:Array in scenesToCreate)
            {
                var sceneTitle:String = sceneToCreate[0];
                var sceneClass:Class  = sceneToCreate[1];
                
                var button:ButtonStarling = new ButtonStarling(buttonTexture, sceneTitle);
                button.x = count % 2 == 0 ? 28 : 167;
                button.y = 155 + int(count / 2) * 46;
                button.name = getQualifiedClassName(sceneClass);
                addChild(button);
                
                if (scenesToCreate.length % 2 != 0 && count % 2 == 1)
                    button.y += 24;
                
                ++count;
            }
            
            // show information about rendering method (hardware/software)
            
            var driverInfo:String = StarlingStarling.context.driverInfo;
            var infoText:TextFieldStarling = new TextFieldStarling(310, 64, driverInfo, "Verdana", 10);
            infoText.x = 5;
            infoText.y = 475 - infoText.height;
            infoText.vAlign = VAlignStarling.BOTTOM;
            infoText.addEventListener(TouchEventStarling.TOUCH, onInfoTextTouched);
            addChildAt(infoText, 0);
        }
        
        private function onInfoTextTouched(event:TouchEventStarling):void
        {
            if (event.getTouch(this, TouchPhaseStarling.ENDED))
                StarlingStarling.current.showStats = !StarlingStarling.current.showStats;
        }
    }
}