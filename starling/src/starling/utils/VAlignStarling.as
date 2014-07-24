// =================================================================================================
//
//	Starling Framework
//	Copyright 2011 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.utils
{
    import starling.errors.AbstractClassErrorStarling;

    /** A class that provides constant values for vertical alignment of objects. */
    public final class VAlignStarling
    {
        /** @private */
        public function VAlignStarling() { throw new AbstractClassErrorStarling(); }
        
        /** Top alignment. */
        public static const TOP:String    = "top";
        
        /** Centered alignment. */
        public static const CENTER:String = "center";
        
        /** Bottom alignment. */
        public static const BOTTOM:String = "bottom";
        
        /** Indicates whether the given alignment string is valid. */
        public static function isValid(vAlign:String):Boolean
        {
            return vAlign == TOP || vAlign == CENTER || vAlign == BOTTOM;
        }
    }
}