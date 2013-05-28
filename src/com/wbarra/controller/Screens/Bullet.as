package com.wbarra.controller.Screens
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Bullet extends Sprite
	{
		private var _alive:Boolean = false;
		private var _posX:Number;
		private var _posY:Number;
		private var _speed:Number = 3;
		private var _changeX:Number;
		private var _changeY:Number;
		private var _angle:Number;
		private var _rads:Number;
		private var _distX:Number;
		private var _distY:Number;
		
		public function Bullet(alive = false)
		{
			super();
			var bullet:Image = Image.fromBitmap(new AllMyImages.BulletImg());
			addChild(bullet);
			_alive = alive;
		}
		public function bulletTargetingSystem():void
		{
			
			if (_alive == true)
			{
//				_changeX  = _bulletTarget._newX - x;
//				_changeY  = _bulletTarget._newY -y;
				_angle    = Math.atan2(_changeY, _changeX) * (180/ Math.PI) ;
				_rads     = _angle * Math.PI /180;
				
				x += Math.cos(_rads) * _speed;
				y += Math.sin(_rads) * _speed;
				
				//setting distance to be a positive number 
//				_distanceX = x - _bulletTarget.x;
//				_distanceY = y - _bulletTarget.y;
				
				if (_distX < 0)
				{
					_distX *= -1;
				}
				if(_distY < 0)
				{
					_distY *= -1;
				}
				
//				if (!_bulletTarget._alive)
//				{
//					//bullets disipate 
//					alpha -= .05;
//				}
			}
		}
	}
}