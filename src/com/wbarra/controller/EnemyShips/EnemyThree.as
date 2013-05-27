package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyImages.AllMyImages;
	
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class EnemyThree extends Sprite
	{
		private var _speedX:Number = 3;
		private var _speedY:Number = 3;
		private var _alive:Boolean;
		private var _newX:Number;
		private var _newY:Number;
		private var _changeX:Number;
		private var _changeY:Number;
		private var _angle:Number;
		private var _rads:Number;
		private var _timer:Timer;
		private var _placementVar:Boolean;
		
		public function EnemyThree()
		{
			super();
			// I am a randome direction moving ship. 
			var myImage:Image = Image.fromBitmap(new AllMyImages.EnemyThreeImage());
			addChild(myImage);
			_alive = true;	
			spawnPoint();
		}
		private function spawnPoint():void
		{
			// I set the spawn point of the ship somewhere in the stage. 
			var tempVar:Number;
			_placementVar = Math.random() < 0.5;
				y =  745;
		}
		public function enemyMove():void
		{
//			x += _speedX;
			y += _speedY;
			
//			if (x <= 50 || x >= 874)
//			{
//				_speedX *= -1;
//			}
			if (y <= 0 || y >= 750)
			{
				_speedY *= -1;
			}
		}
	}
}