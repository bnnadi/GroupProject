package com.wbarra.controller.objects
{
	import com.wbarra.controller.allMyImages.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Bullet extends Sprite
	{
		private var _bullet:Image;
		public var vx:Number;
		public var vy:Number;
		public var alive:Boolean;
		public var speed:int = 15;
		public var id:int;
		
		public function Bullet()
		{
			super();
			setup();
		}
		
		private function setup():void
		{
			// Creating the bullet using the image
			_bullet = Image.fromBitmap(new AllMyImages.BulletImg());
			addChild(_bullet);
		}
		
		public function update():void
		{
			this.x += vx * speed;
			this.y += vy * speed;
		}
	}
}