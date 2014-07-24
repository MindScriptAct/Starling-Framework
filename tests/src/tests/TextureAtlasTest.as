// =================================================================================================
//
//	Starling Framework
//	Copyright 2011 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package tests
{
    import flash.display3D.Context3DTextureFormat;
    import flash.geom.Rectangle;
    
    import flexunit.framework.Assert;
    
    import starling.textures.ConcreteTextureStarling;
    import starling.textures.SubTextureStarling;
    import starling.textures.TextureStarling;
    import starling.textures.TextureAtlasStarling;

    public class TextureAtlasTest
    {		
        [Test]
        public function testXmlParsing():void
        {
            var format:String = Context3DTextureFormat.BGRA;
            var xml:XML = 
                <TextureAtlas>
                    <SubTexture name='ann' x='0'   y='0'  width='55.5' height='16' />
                    <SubTexture name='bob' x='16'  y='32' width='16'   height='32' />
                </TextureAtlas>;
            
            var texture:TextureStarling = new ConcreteTextureStarling(null, format, 64, 64, false, false);
            var atlas:TextureAtlasStarling = new TextureAtlasStarling(texture, xml);
            
            var ann:TextureStarling = atlas.getTexture("ann");
            var bob:TextureStarling = atlas.getTexture("bob");
            
            Assert.assertTrue(ann is SubTextureStarling);
            Assert.assertTrue(bob    is SubTextureStarling);
            
            Assert.assertEquals(55.5, ann.width);
            Assert.assertEquals(16, ann.height);
            Assert.assertEquals(16, bob.width);
            Assert.assertEquals(32, bob.height);
            
            var annST:SubTextureStarling = ann as SubTextureStarling;
            var bobST:SubTextureStarling = bob as SubTextureStarling;
            
            Assert.assertEquals(0, annST.clipping.x);
            Assert.assertEquals(0, annST.clipping.y);
            Assert.assertEquals(0.25, bobST.clipping.x);
            Assert.assertEquals(0.5, bobST.clipping.y);
        }
        
        [Test]
        public function testManualCreation():void
        {
            var format:String = Context3DTextureFormat.BGRA;
            var texture:TextureStarling = new ConcreteTextureStarling(null, format, 64, 64, false, false);
            var atlas:TextureAtlasStarling = new TextureAtlasStarling(texture);
            
            atlas.addRegion("ann", new Rectangle(0, 0, 55.5, 16));
            atlas.addRegion("bob", new Rectangle(16, 32, 16, 32));
            
            Assert.assertNotNull(atlas.getTexture("ann"));
            Assert.assertNotNull(atlas.getTexture("bob"));
            Assert.assertNull(atlas.getTexture("carl"));
            
            atlas.removeRegion("carl"); // should not blow up
            atlas.removeRegion("bob");
            
            Assert.assertNull(atlas.getTexture("bob"));
        }
        
        [Test]
        public function testGetTextures():void
        {
            var format:String = Context3DTextureFormat.BGRA;
            var texture:TextureStarling = new ConcreteTextureStarling(null, format, 64, 64, false, false);
            var atlas:TextureAtlasStarling = new TextureAtlasStarling(texture);
            
            Assert.assertEquals(texture, atlas.texture);
            
            atlas.addRegion("ann", new Rectangle(0, 0, 8, 8));
            atlas.addRegion("prefix_3", new Rectangle(8, 0, 3, 8));
            atlas.addRegion("prefix_1", new Rectangle(16, 0, 1, 8));
            atlas.addRegion("bob", new Rectangle(24, 0, 8, 8));
            atlas.addRegion("prefix_2", new Rectangle(32, 0, 2, 8));
            
            var textures:Vector.<TextureStarling> = atlas.getTextures("prefix_");
            
            Assert.assertEquals(3, textures.length);
            Assert.assertEquals(1, textures[0].width);
            Assert.assertEquals(2, textures[1].width);
            Assert.assertEquals(3, textures[2].width);
        }
    }
}