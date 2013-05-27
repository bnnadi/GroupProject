package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class EnemyOne extends Sprite 
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
		
		
		public function EnemyOne()
		{
			super();
			// I am  homing ship.
			var myImage:Image = Image.fromBitmap(new AllMyImages.EnemyShip());
			addChild(myImage);
			_alive = true;
			
			// calling spawn point function 
			spawnPoint();
			
			
		}
		
		private function spawnPoint():void
		{
			// I set the spawn point of the ship somewhere in the stage. 
			var tempVar:Number;
			x = Math.random()*874+50;
			// randomizing either top or bottom placement of the object
			var placementVar:Boolean;
			for (var i:int = 0; i < 5; i++) 
			{
				placementVar = Math.random() < 0.5;
			}
			// setting my placement either coming from the top 
			if (placementVar)
			{
				y = Math.random()*50+718;
			}
			// or from the bottom 
			else 
			{
				y = Math.random()*50;
			}
		}
		public function enemyMove(heroX:Number, heroY:Number):void
		{
			if (_alive)
			{
				// have to figure out a way to dumb down these ships. Some how make them not as perfect and have a secondary set of movement instructions. or something. 
				// finding the change X and Change Y 
				_changeX = heroX - x;
				_changeY = heroY - y;
				_angle = Math.atan2(_changeY, _changeX) * (180/ Math.PI);
				_rads = _angle * Math.PI/180;
				// setting the direction of the ships 
				
				x += (Math.cos(_rads) * _speedX);
				y += (Math.sin(_rads) * _speedY);
			}// end alive if 
		
			

		}
	}
}