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
		private var _targetX:Number;
		private var _targetY:Number;
		
		
		public function Bullet(alive = false)
		{
			super();
			var bullet:Image = Image.fromBitmap(new AllMyImages.BulletImg());
			scaleX = scaleY = .5;
			addChild(bullet);
			_alive = alive;
		}

		public function get alive():Boolean
		{
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		public function get targetY():Number
		{
			return _targetY;
		}

		public function set targetY(value:Number):void
		{
			_targetY = value;
		}

		public function get targetX():Number
		{
			return _targetX;
		}

		public function set targetX(value:Number):void
		{
			_targetX = value;
		}

		public function bulletTargetingSystem():void
		{
			
			if (_alive == true)
			{
				_changeX  = targetX - x;
				_changeY  = targetY - y;
				_angle    = Math.atan2(_changeY, _changeX) * (180/ Math.PI) ;
				_rads     = _angle * Math.PI /180;
				x += Math.cos(_angle) * _speed;
				y += Math.sin(_angle) * _speed;
//				x += Math.cos(_rads) * _speed;
//				y += Math.sin(_rads) * _speed;
				
//				var mc = pEvt.currentTarget;
//				var angleRadian = Math.atan2(mouseY - mc.y,mouseX - mc.x);
//				var angleDegree = angleRadian * 180 / Math.PI;
//				mc.rotation = angleDegree;
//				txtAngle.text = Math.round(angleDegree) + "°";
				// Get the current object (Bullet)
//				var b = pEvent.currentTarget;
				
//				b.x +=  Math.cos(b.angleRadian) * speed;
//				// On Y axis use the sinus angle
//				b.y +=  Math.sin(b.angleRadian) * speed;
//				// Orient the bullet to the direction
//				b.rotation = b.angleRadian * 180 / Math.PI;
				
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