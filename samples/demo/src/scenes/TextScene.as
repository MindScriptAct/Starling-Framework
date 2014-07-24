package scenes
{
    import starling.text.BitmapFontStarling;
    import starling.text.TextFieldStarling;
    import starling.utils.ColorStarling;
    import starling.utils.HAlignStarling;
    import starling.utils.VAlignStarling;

    public class TextScene extends Scene
    {
        public function TextScene()
        {
            init();
        }

        private function init():void
        {
            // TrueType fonts
            
            var offset:int = 10;
            var ttFont:String = "Ubuntu";
            var ttFontSize:int = 19; 
            
            var colorTF:TextFieldStarling = new TextFieldStarling(300, 80,
                "TextFields can have a border and a color. They can be aligned in different ways, ...", 
                ttFont, ttFontSize);
            colorTF.x = colorTF.y = offset;
            colorTF.border = true;
            colorTF.color = 0x333399;
            addChild(colorTF);
            
            var leftTF:TextFieldStarling = new TextFieldStarling(145, 80,
                "... e.g.\ntop-left ...", ttFont, ttFontSize);
            leftTF.x = offset;
            leftTF.y = colorTF.y + colorTF.height + offset;
            leftTF.hAlign = HAlignStarling.LEFT;
            leftTF.vAlign = VAlignStarling.TOP;
            leftTF.border = true;
            leftTF.color = 0x993333;
            addChild(leftTF);
            
            var rightTF:TextFieldStarling = new TextFieldStarling(145, 80,
                "... or\nbottom right ...", ttFont, ttFontSize);
            rightTF.x = 2*offset + leftTF.width;
            rightTF.y = leftTF.y;
            rightTF.hAlign = HAlignStarling.RIGHT;
            rightTF.vAlign = VAlignStarling.BOTTOM;
            rightTF.color = 0x228822;
            rightTF.border = true;
            addChild(rightTF);
            
            var fontTF:TextFieldStarling = new TextFieldStarling(300, 80,
                "... or centered. Embedded fonts are detected automatically.",
                ttFont, ttFontSize, 0x0, true);
            fontTF.x = offset;
            fontTF.y = leftTF.y + leftTF.height + offset;
            fontTF.border = true;
            addChild(fontTF);
            
            // Bitmap fonts!
            
            // First, you will need to create a bitmap font texture.
            //
            // E.g. with this tool: www.angelcode.com/products/bmfont/ or one that uses the same
            // data format. Export the font data as an XML file, and the texture as a png with white
            // characters on a transparent background (32 bit).
            //
            // Then, you just have to register the font at the TextField class.    
            // Look at the file "Assets.as" to see how this is done.
            // After that, you can use them just like a conventional TrueType font.
            
            var bmpFontTF:TextFieldStarling = new TextFieldStarling(300, 150,
                "It is very easy to use Bitmap fonts,\nas well!", "Desyrel");
            
            bmpFontTF.fontSize = BitmapFontStarling.NATIVE_SIZE; // the native bitmap font size, no scaling
            bmpFontTF.color = ColorStarling.WHITE; // use white to use the texture as it is (no tinting)
            bmpFontTF.x = offset;
            bmpFontTF.y = fontTF.y + fontTF.height + offset;
            addChild(bmpFontTF);
            
            // A tip: you can add the font-texture to your standard texture atlas and reference 
            // it from there. That way, you save texture space and avoid another texture-switch.
        }
    }
}