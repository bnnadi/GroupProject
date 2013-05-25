package com.wbarra.controller.objects
{
	import com.wbarra.controller.allMyImages.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Bullet extends Sprite
	{
		private var _bullet:Image;
		
		public function Bullet()
		{
			super();
			
			setup();
		}
		
		private function setup():void
		{
			// Creating the bullet using the image
			_bullet = Image.fromBitmap(new AllMyImages.BulletImg());
		}
		
		public function move(mouseX:Number, mouseY:Number):void
		{
			_bullet.x = mouseX;
			_bullet.y = mouseY;
			
		}
	}
}