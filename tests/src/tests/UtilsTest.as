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
    import flexunit.framework.Assert;
    
    import starling.utils.deg2radStarling;
    import starling.utils.executeStarling;
    import starling.utils.formatStringStarling;
    import starling.utils.getNextPowerOfTwoStarling;
    import starling.utils.rad2degStarling;

    public class UtilsTest
    {		
        [Test]
        public function testFormatString():void
        {
            Assert.assertEquals("This is a test.", formatStringStarling("This is {0} test.", "a"));
            Assert.assertEquals("aba{2}", formatStringStarling("{0}{1}{0}{2}", "a", "b"));
            Assert.assertEquals("1{2}21", formatStringStarling("{0}{2}{1}{0}", 1, 2));
        }

        [Test]
        public function testGetNextPowerOfTwo():void
        {
            Assert.assertEquals(1,   getNextPowerOfTwoStarling(0));
            Assert.assertEquals(1,   getNextPowerOfTwoStarling(1));
            Assert.assertEquals(2,   getNextPowerOfTwoStarling(2));
            Assert.assertEquals(4,   getNextPowerOfTwoStarling(3));
            Assert.assertEquals(4,   getNextPowerOfTwoStarling(4));
            Assert.assertEquals(8,   getNextPowerOfTwoStarling(6));
            Assert.assertEquals(32,  getNextPowerOfTwoStarling(17));
            Assert.assertEquals(64,  getNextPowerOfTwoStarling(63));
            Assert.assertEquals(256, getNextPowerOfTwoStarling(129));
            Assert.assertEquals(256, getNextPowerOfTwoStarling(255));
            Assert.assertEquals(256, getNextPowerOfTwoStarling(256));
        }
        
        [Test]
        public function testRad2Deg():void
        {
            Assert.assertEquals(  0.0, rad2degStarling(0));
            Assert.assertEquals( 90.0, rad2degStarling(Math.PI / 2.0));
            Assert.assertEquals(180.0, rad2degStarling(Math.PI));
            Assert.assertEquals(270.0, rad2degStarling(Math.PI / 2.0 * 3.0));
            Assert.assertEquals(360.0, rad2degStarling(2 * Math.PI));
        }
        
        [Test]
        public function testDeg2Rad():void
        {
            Assert.assertEquals(0.0, deg2radStarling(0));
            Assert.assertEquals(Math.PI / 2.0, deg2radStarling(90.0));
            Assert.assertEquals(Math.PI, deg2radStarling(180.0));
            Assert.assertEquals(Math.PI / 2.0 * 3.0, deg2radStarling(270.0));
            Assert.assertEquals(2 * Math.PI, deg2radStarling(360.0));
        } 

        [Test]
        public function testExecute():void
        {
            executeStarling(funcOne, "a", "b");
            executeStarling(funcOne, "a", "b", "c");
            executeStarling(funcTwo, "a");

            function funcOne(a:String, b:String):void
            {
                Assert.assertEquals("a", a);
                Assert.assertEquals("b", b);
            }

            function funcTwo(a:String, b:String):void
            {
                Assert.assertEquals("a", a);
                Assert.assertNull(b);
            }
        }
    }
}