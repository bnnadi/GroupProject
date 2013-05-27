package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class TestBall extends Sprite
	{
		public function TestBall()
		{
			super();
			
			var ball:Image = Image.fromBitmap(new AllMyImages.ball());
			addChild(ball);
		}
		
		public function ballMove():void
		{
			
		}
	}
}